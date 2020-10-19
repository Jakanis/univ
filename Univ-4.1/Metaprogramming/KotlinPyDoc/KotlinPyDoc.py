import argparse
import os
import os.path
from itertools import groupby
from os import listdir
from os.path import isfile, join, isdir, relpath
from time import strftime, localtime

import Documentor

OUTPUT_ROOT = str()

def parsePackageInfo(abspath, absoutput):
	input = str()
	with open(abspath, 'r') as fp:
		input = fp.read()
	resultingHTML = '''
	There should be package doc but there is only content:
	%s
	''' % input
	with open(join(absoutput, 'package-info.html'), 'w') as fp:
		fp.write(resultingHTML)


def htmlHeader(mainPagePath: str, contentsPath: str, abcPath: str):
	return '''
<!DOCTYPE html>
<html lang="en">
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<title>Hello, world!</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand"
		   href="{mainPagePath}">KotlinPyDoc</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
				aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="{mainPagePath}">Main page</a>
				</li>
	
				<li class="nav-item">
					<a class="nav-link" href="{contentsPath}">Contents</a>
				</li>
	
				<li class="nav-item">
					<a class="nav-link" href="{abcPath}">Index</a>
				</li>
			</ul>
		</div>
	</nav>
	'''.format(mainPagePath=mainPagePath, contentsPath=contentsPath, abcPath=abcPath)


def generateHomepage(absoutput, projectName, singlefilemode, elementsCount):
	singleFileWarn = '<div class="alert alert-info" role="alert">GENERATED IN SINGLE-FILE-MODE</div>' if singlefilemode else ''
	resultingHTML = """
{navbar}
<div class="container m-4">
	<div class="alert alert-secondary" role="alert">
	  {projectName}
	</div>
	<div class="alert alert-secondary" role="alert">
	  {generationDate}
	</div>
	<div class="alert alert-secondary" role="alert">
	  KotlinPyDoc
	</div>
	<div class="alert alert-danger" role="alert">
	  {elementsCount} elements
	</div>
    {singlefilemode}
</div>
</body>
</html>
	""".format(projectName=projectName, generationDate=strftime("%d.%m.%Y %H:%M:%S", localtime()),
			   singlefilemode=singleFileWarn, navbar=htmlHeader('./index.html', './dir_doc.html', './abc.html'), elementsCount=elementsCount)
	with open(join(absoutput, 'index.html'), 'w') as fp:
		fp.write(resultingHTML)


def generateDirDoc(pathToOutput: str, files: list, dirs:list=None):
	htmlResult = '''
	{header}
	'''.format(header=htmlHeader(join(pathToOutput,'index.html'),join(pathToOutput,'dir_doc.html'),join(pathToOutput,'abc.html')))
	if pathToOutput!='.':
		htmlResult+='<div class="alert alert-dark"><a href="../dir_doc.html">..</a></div>'
	if (dirs):
		for dir in dirs:
			htmlResult+='<div class="alert alert-warning"><a href="{dirName}/dir_doc.html">{dirName}</a></div>'.format(dirName=dir)
	for file in files:
		htmlResult+='<div class="alert alert-light"><a href="{fileName}_doc.html">{fileName}</a></div>'.format(fileName=file)
	htmlResult+='''
	</body>
	</html>
	'''
	return htmlResult


def generateAbc(listElements: list, abcPath: str):
	listElements.sort(key=lambda k: k.name.lower())
	htmlResult = """
	{navbar}
	<h5 class="alert alert-secondary">Abc</h5>
	""".format(navbar=htmlHeader('./index.html', './dir_doc.html', './abc.html'))  # add html head
	for letter, words in groupby(listElements, key=lambda k: k.name[0].lower()):
		htmlResult += """
		<div class="card bg-light mb-2">
		<div class="card-header">{letter}</div>
		<div class="card-body">
		""".format(letter=letter.upper())  # open card with letter
		for word, elems in groupby(words, key=lambda k: k.name):
			htmlResult += """
        	<div class="card bg-light my-1">
            <div class="card-header text-success">{word}</div>
            """.format(word=word)  # open card with word
			for elem in elems:
				htmlResult += '''
				<div class="card-header text-dark"><a href="{pathToFile}#{elemId}">{elem}</a></div>
				'''.format(elem=Documentor.htmlfy(
					elem.title.replace(elem.name, elem.parent.name + '.' + elem.name) if hasattr(elem, 'parent') else elem.title),
						   pathToFile=os.path.relpath(elem.filePath, abcPath),
						   elemId=elem.id)  # add card with elem
			htmlResult += "</div>"  # close card with word
		htmlResult += "</div></div>"  # close card with letter
	htmlResult += "</body></html>"  # add html bottom
	with open(join(abcPath, 'abc.html'), 'w') as fp:
		fp.write(htmlResult)


def parsedir(abspath, absoutput, recursive: bool = False):
	onlyKtFiles = [f for f in listdir(abspath) if isfile(join(abspath, f)) and f.endswith('.kt')]
	listElements = list()
	for file in onlyKtFiles:
		oneListElements = parsefile(join(abspath, file), absoutput)
		listElements.extend(oneListElements)
	if os.path.exists(join(abspath, 'package-info.java')):
		parsePackageInfo(join(abspath, 'package-info.java'), absoutput)
	onlyDirs=list()
	if recursive:
		onlyDirs = [d for d in listdir(abspath) if isdir(join(abspath, d))]
		for dir in onlyDirs:
			listElements.extend(parsedir(join(abspath, dir), join(absoutput, dir),recursive))
	dirDocPath = join(absoutput, 'dir_doc.html')
	os.makedirs(os.path.dirname(dirDocPath), exist_ok=True)
	with open(dirDocPath, 'w') as fp:
		fp.write(generateDirDoc(relpath(OUTPUT_ROOT, absoutput), onlyKtFiles, dirs=onlyDirs))
	return listElements


def parsefile(abspath, absoutput):
	pathToOutput = relpath(OUTPUT_ROOT, absoutput)
	resultingHTML, listElements = Documentor.parsefile(abspath, htmlHeader(join(pathToOutput,'index.html'),join(pathToOutput,'dir_doc.html'),join(pathToOutput,'abc.html')))
	_, filename = os.path.split(abspath)
	absoutput = join(absoutput, filename + '_doc.html')
	os.makedirs(os.path.dirname(absoutput), exist_ok=True)
	with open(absoutput, 'w') as fp:
		fp.write(resultingHTML)
	for element in listElements:
		element.filePath = absoutput
	return listElements


def parse(abspath, absoutput, recursive: bool):
	objectPath, objectName = os.path.split(abspath)
	if absoutput == None:
		absoutput = os.path.join(objectPath, objectName + '_docs')
	global OUTPUT_ROOT
	OUTPUT_ROOT=absoutput
	listElements = list()
	singlefilemode = False
	if (os.path.isfile(abspath)):
		listElements = parsefile(abspath, absoutput)
		singlefilemode = True
		dirDocPath = join(absoutput, 'dir_doc.html')
		os.makedirs(os.path.dirname(dirDocPath), exist_ok=True)
		with open(dirDocPath, 'w') as fp:
			fp.write(generateDirDoc(relpath(OUTPUT_ROOT, absoutput), [objectName]))
	if (os.path.isdir(abspath)):
		listElements = parsedir(abspath, absoutput, recursive)
	generateHomepage(absoutput, objectName, singlefilemode, len(listElements))
	generateAbc(listElements, absoutput)


if __name__ == '__main__':
	parser = argparse.ArgumentParser(prog='KotlinPyDoc', description='Generate documentation for Kotlin project.')
	parser.add_argument("path", help="Path to the folder or Kotlin file")
	parser.add_argument("-r", "--recursive", action="store_true", help="enable recursive mode(folders only)",
						default=False)
	parser.add_argument("--output", help="output path")
	args = parser.parse_args()

	abspath = os.path.abspath(os.path.expanduser(os.path.expandvars(args.path)))

	absoutput = args.output
	if (absoutput != None):
		absoutput = os.path.abspath(os.path.expanduser(os.path.expandvars(absoutput)))

	parse(abspath, absoutput, args.recursive)
