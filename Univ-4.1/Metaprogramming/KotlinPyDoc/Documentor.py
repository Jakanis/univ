import math
import re
from enum import Enum
from os.path import split

COMMENT_ENTITY_PAIRS_REGEX = '(/\*\*[\s|\S]+?\*/\s*\n)?((\s*?@.+\n)*?)(.*(([ \n]?fun .+?\).*?(?=\{|=|\n))|([ \n]?interface .+)|([ \n]?class .+)|([ \n]?val .+)|(^object .+)))'


class ElementType(Enum):
	CLASS, INTERFACE, FUNC, VAL, FILE, DIR, OBJECT = range(7)


class Element:
	def __init__(self, content: str, comment: str, annotations: str, type: ElementType, name: str, title: str):
		self.content = content
		self.comment = comment
		self.annotations = annotations
		self.nest = math.floor((len(self.content) - len(self.content.lstrip(' '))) / 4)
		self.type = type
		self.name = name
		self.title = title

	def str(self):
		return "%s%s%s\n%s---------------------------\n" % (self.comment, self.annotations, self.content, self.nest)


def parseFileToList(file: str):
	with open(file) as fp:
		res = list()
		text = fp.read()
		regex = re.compile(r'\A(/\*[\s|\S]+?\*/\s*\n)')
		fileComment = regex.findall(text)
		fileComment = fileComment[0] if fileComment else ''
		fileImports = re.findall('(?<=^import ).*', text, re.MULTILINE)
		text = re.sub(r'"""[\s\S]*?"""', '', text) #remove multiline strings
		text = re.sub(r'".+"', '', text) #remove strings
		text = re.sub(r'\A(/\*[\s|\S]+?\*/\s*\n)', '', text)
		text = re.sub(r'//.*\n', '', text)#remove oneline comments
		regex = re.compile(COMMENT_ENTITY_PAIRS_REGEX)
		parsed = regex.findall(text)
		for result in parsed:
			if ('suspend' in result[3]):
				continue
			if ('companion' in result[3]):
				continue
			if ('inline' in result[3]):
				continue
			if ('"' in result[3]):
				if ('""' not in result[3]):
					continue
			if ('fun (' in result[3]): # todo: as anonymous function check was added to COMMENT_ENTITY_PAIRS_REGEX
				continue
			elementType = ElementType
			name = str()
			elemTitle = str()
			if result[5]:
				elementType = ElementType.FUNC
				# name = re.findall('(?<=fun)[\w\.]+', result[5]).pop()
				name = re.findall(r'(?<=fun ).+(?=\()', result[5]).pop()
				if name == '(':
					continue
				elemTitle = re.findall('(fun.*\(.*\))', result[3]).pop()
			elif result[6]:
				elementType = ElementType.INTERFACE
				name = re.findall('(?<=interface )(\w+)', result[6]).pop()
				elemTitle = re.findall('(interface \w+)', result[3]).pop()
			elif result[7]:
				elementType = ElementType.CLASS
				name = re.findall('(?<=class )(\w+)', result[7]).pop()
				elemTitle = re.findall('(class \w+)', result[3]).pop()
			elif result[8]:
				if ('public' not in result[8]):  # if not a public val
					continue
				elementType = ElementType.VAL
				name = re.findall('(?<=val )(\w+)', result[8]).pop()
				elemTitle = re.findall('(val .*)', result[3]).pop()
			elif result[9]:
				elementType = ElementType.OBJECT
				name = re.findall('(?<=object )(\w+)', result[9]).pop()
				elemTitle = re.findall('(object \w+)', result[3]).pop()
			element = Element(result[3].rstrip(' {'), result[0], result[1], elementType, name, elemTitle)
			res.append(element)
		return res, fileComment, fileImports


def packListToTree(elements, pos=0, level=0, parent=None):
	res = list()
	current = None
	while pos < len(elements):
		last = current
		current = elements[pos]
		nest = current.nest
		if (nest == level):
			if parent:
				current.parent = parent
			res.append(current)
		if (nest > level):
			if last:
				last.children, pos = packListToTree(elements, pos, level + 1, last)
			else:
				_, pos = packListToTree(elements, pos, level + 1, last)
		if (nest < level):
			break
		pos += 1
	return res, pos - 1


def htmlfy(input: str):
	return input.replace("<", "&lt").replace(">", "&gt").replace('\n', '<br>')


def cleanComment(input: str):
	output = input.strip('/* \n')
	output = re.sub(r'((?<=\n)\s*?\*)', ' ', output)
	output = htmlfy(output)
	return output


def printTreeToHTML(tree, indent=0):
	res = str()
	for element in tree:
		content = ' '
		if (hasattr(element, 'children')):
			content = printTreeToHTML(element.children, indent + 1)
		element.annotations = re.sub('//.*?\n', '\n', element.annotations)  # remove one-line comment
		annotations = r'<div class="card-header text-info">' + htmlfy(
			element.annotations.strip('\n')) + '</div>' if element.annotations else ''
		comment = cleanComment(element.comment) if element.comment else "*No documentation*"
		res += """
				<div class="card bg-light mb-3" id="%s">
				  <div class="card-header text-success"> %s</div>
				  %s
				  <div class="card-header text-dark"> %s </div>
				  <div class="card-body">
					%s
				  </div>
				</div>
				""" % (
			element.id, comment, annotations, htmlfy(element.content), content)
	return res


def makeUniqueIdsAndNames(listedElements):
	names = [elem.name for elem in listedElements]
	duplicates = set([x for x in names if names.count(x) > 1])
	counter = 1
	for elem in listedElements:
		if elem.name in duplicates:
			elem.id = elem.name + str(counter)
			counter += 1
		else:
			elem.id = elem.name
	return listedElements


def parsefile(filepath: str, htmlHeader: str):
	pathToFile, fileName = split(filepath)

	listedElements, fileComment, fileImports = parseFileToList(filepath)

	root = Element(filepath, fileComment, 'FILE', ElementType.FILE, fileName, fileName)

	root.children, lastPos = packListToTree(listedElements)
	if lastPos != len(listedElements) - 1:
		raise IndexError

	listedElements = makeUniqueIdsAndNames(listedElements)

	resultingHTML = """
		{header}
			<a href="./dir_doc.html" class="btn btn-secondary btn-lg m-2">Back to folder</a>
			<h5 class="alert alert-secondary">{fileName}</h5>
			<h5 class="alert alert-danger">File imports:<br/>{fileImports}</h5>
			<h5 class="alert alert-light text-primary">{fileComment}</h5>
			{fileContent}
		</body>
		</html>
		""".format(header=htmlHeader, fileComment=cleanComment(fileComment), fileContent=printTreeToHTML(root.children),
				   fileName=fileName, fileImports='<br/>'.join(fileImports))

	return resultingHTML, listedElements
