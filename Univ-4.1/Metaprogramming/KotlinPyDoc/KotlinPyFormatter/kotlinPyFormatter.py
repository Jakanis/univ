import argparse
import os
import re


class BracketsError(RuntimeError):
	def __init__(self):
		pass


class KotlinPyFormatter:
	_indentSize = " " * 4
	_lineMaxLength = 80
	__leftBraceLines = list()
	__rightBraceLines = list()

	def __splitLongLineByDot(self, line, indentation):
		results = list()
		splittedByDot = line.split('.')
		results.append(self._indentSize * indentation + splittedByDot[0].strip())
		for i, linePart in enumerate(splittedByDot):
			if i == 0:
				continue
			if splittedByDot[i - 1][-1] == "?":
				results[-1] = results[-1][:-1]
				results.append(self._indentSize * indentation + "?." + linePart.strip())
			else:
				results.append(self._indentSize * indentation + "." + linePart.strip())
		return results

	def __splitLongLineByComma(self, line, indentation):
		results = list()
		splittedByDot = line.split(',')
		first = splittedByDot[0].strip()
		del splittedByDot[0]
		rightmostOpenBrace = first.rfind('(')
		results.append(first[:rightmostOpenBrace + 1])
		if len(splittedByDot) > 0:
			results.append(self._indentSize * indentation + first[rightmostOpenBrace + 1:].strip() + ',')
		else:
			results.append(self._indentSize * indentation + first[rightmostOpenBrace + 1:].strip())
		for linePart in splittedByDot:
			results.append(self._indentSize * indentation + linePart.strip() + ',')
		return results

	def __splitLongLineByRightmostComma(self, line, indentation):
		results = list()
		splittedByDot = line.split(',')
		last = splittedByDot[-1].strip()
		del splittedByDot[-1]
		for linePart in splittedByDot:
			results.append(self._indentSize * indentation + linePart.strip() + ',')
		results.append(self._indentSize * indentation + last.strip())
		return results

	def __longLineWorker(self, line, indentation):
		results = list()
		if len(line) < self._lineMaxLength:
			results.append((self._indentSize * indentation + line))
			return results

		if "class" in line and "):" in line:
			leftPart, rightPart = line.split("):")
			results.extend(self.__splitLongLineByComma(leftPart, indentation + 1))
			rightPart = ") :" + rightPart
			braces = re.findall(r'\([^)]+\)', rightPart)
			if braces is not None:
				for generics in braces:
					last = generics
					if ',' in generics:
						generics = generics.replace(',', '`')
						rightPart = rightPart.replace(last, generics)
			temp = self.__splitLongLineByRightmostComma(rightPart, indentation + 1)
			results.extend(item.replace('`', ',') for item in temp)

		elif "class" in line:
			leftPart, rightPart = line.split(":")
			leftPart = leftPart + ":"
			results.extend(self.__splitLongLineByRightmostComma(leftPart, indentation))
			results.extend(self.__splitLongLineByRightmostComma(rightPart, indentation + 1))
		elif "if (" in line or "when (" in line:
			temp = list()
			splitOR = line.split("||")
			for partOR in splitOR:
				splitAND = partOR.split("&&")
				for partAND in splitAND:
					temp.append(self._indentSize * (indentation + 1) + partAND.strip() + " &&")
				temp[-1] = temp[-1].replace("&&", "||")
			temp[0] = temp[0].strip()
			last = temp[-1].replace("||", "")
			rightmostBrace = last.rfind(')')
			temp[-1] = last[:rightmostBrace]
			temp.append(last[rightmostBrace:])
			results.extend(temp)
		elif " val " in line and "=" in line:
			leftPart, rightPart = line.split('=', 1)
			results.append(leftPart + '=')
			results.extend(self.__longLineWorker(rightPart.strip(), indentation + 1))
		elif "." in line:
			results.extend(self.__splitLongLineByDot(line, indentation + 1))
		elif "," in line:
			results.extend(self.__splitLongLineByComma(line, indentation + 1))
		elif "->" in line:
			leftPart, rightPart = line.split('->', 1)
			results.append(leftPart + '->')
			results.extend(self.__longLineWorker(rightPart.strip(), indentation + 1))
		else:
			results.append(line)
		return results

	@staticmethod
	def __spaceCleanWorker(line):
		line = line.replace(r'=', r' = ')
		line = line.replace(r'>', r' > ')
		line = line.replace(r'<', r' < ')
		line = line.replace(r':', r' : ')
		line = line.replace(r'+', r' + ')
		line = line.replace(r'-', r' - ')
		line = line.replace(r'*', r' * ')
		line = line.replace(r'[^/]/[^/]', r' / ')
		line = re.sub(r'\s+', ' ', line)
		return line

	@staticmethod
	def __keywordsWorker(line):
		while re.search(r'^\sif', line) is not None:
			line = line.replace('if', ' if')
		while re.search(r'if\(', line) is not None:
			line = line.replace('if(', 'if (')

		while re.search(r'^\swhile', line) is not None:
			line = line.replace('while', ' while')
		while re.search(r'while\(', line) is not None:
			line = line.replace('while(', 'while (')

		while re.search(r'^\swhen', line) is not None:
			line = line.replace('when', ' when')
		while re.search(r'when\(', line) is not None:
			line = line.replace('when(', 'when (')

		while re.search(r'^\sfor', line) is not None:
			line = line.replace('for', ' for')
		while re.search(r'for\(', line) is not None:
			line = line.replace('for(', 'for (')
		return line

	@staticmethod
	def __doubleDotWorker(line):
		results = re.findall(r'\([^)]+\)', line)
		results.extend(re.findall(r'val\s.*:', line))
		results.extend(re.findall(r'var\s.*:', line))
		if results is not None:
			for generics in results:
				last = generics
				if ':' in generics:
					generics = generics.replace(' :', ':')
					line = line.replace(last, generics)

		return line

	@staticmethod
	def __genericsWorker(line):
		results = re.findall(r'<[^>]+>', line)
		if results is not None:
			for generics in results:
				last = generics
				if '||' not in generics and '&&' not in generics:
					generics = generics.replace('< ', '<')
					generics = generics.replace(' >', '>')
					line = line.replace(last, generics)
					line = line.replace(' ' + generics, generics)
					line = line.replace(generics + ' ', generics)
		return line

	@staticmethod
	def __spaceWorker(line):
		while re.search(r'\s\)', line) is not None:
			line = line.replace(' )', ')')
		while re.search(r'\(\s', line) is not None:
			line = line.replace('( ', '(')
		while re.search(r'\s\]', line) is not None:
			line = line.replace(' ]', ']')
		while re.search(r'\[\s', line) is not None:
			line = line.replace('[ ', '[')
		line = line.replace('{', ' {')
		if r'\\ ' not in line:
			line = line.replace(r'\\', r'\\ ')
		line = line.replace(r'= =', r'==')
		line = line.replace(r'! =', r'!=')
		line = line.replace(r'> =', r'>=')
		line = line.replace(r'< =', r'<=')
		line = line.replace(r'? .', r'?.')
		line = line.replace(r'>:', r'> :')
		line = line.replace(r') :', r'):')
		line = line.replace(r': :', r'::')
		line = line.replace(r'object:', r'object :')
		line = line.replace(r'- >', r'->')
		line = line.replace(r' ?', r'?')
		line = line.replace(r'. ', r'.')
		line = line.replace(r' .', r'.')
		return line

	def __openBlockWorker(self, line):
		splittedLines = line.split('{')
		last = splittedLines[-1].rstrip()
		del splittedLines[-1]
		for splittedLine in splittedLines:
			self.__leftBraceLines.append(splittedLine.strip() + " {")
		self.__leftBraceLines.append(last)

	def __closeBlockWorker(self, line):
		splittedLines = line.split('}')
		first = splittedLines[0]
		del splittedLines[0]
		if first != "":
			self.__rightBraceLines.append(first)
		for splittedLine in splittedLines:
			self.__rightBraceLines.append('}' + splittedLine)

	def __intendWorker(self, lines):
		indentation = 0
		results = list()
		comment = False
		for line in lines:

			if r'*/' in line:
				comment = False
				results.append(line.rstrip('\n'))
				continue
			if r'/*' in line or comment:
				comment = True
				results.append(line.rstrip('\n'))
				continue

			if '}' in line:
				indentation -= 1

			if len(line) > self._lineMaxLength:
				results.extend(self.__longLineWorker(line, indentation))
			else:
				results.append(indentation * self._indentSize + line.strip())

			if '{' in line:
				indentation += 1

		return results

	def formatFile(self, inputFileLines, indent=4, lineMaxLength=80, preAnalyze=False):
		results = list()
		self._indentSize = " " * indent
		self._lineMaxLength = lineMaxLength
		if preAnalyze:
			if not self.preAnalyzer(inputFileLines):
				raise BracketsError("Something wrong with brackets in input file")

		comment = False

		for line in inputFileLines:
			if line == '\n':
				results.append(line)
				continue
			if r'*/' in line:
				comment = False
				results.append(line)
				continue
			if r'/*' in line or comment:
				comment = True
				results.append(line)
				continue

			self.__leftBraceLines.clear()
			self.__rightBraceLines.clear()
			line = self.__spaceCleanWorker(line)
			line = self.__keywordsWorker(line)
			line = self.__doubleDotWorker(line)
			line = self.__genericsWorker(line)
			line = self.__spaceWorker(line)
			self.__openBlockWorker(line)
			for blockOpennings in self.__leftBraceLines:
				self.__closeBlockWorker(blockOpennings)
			results.extend(self.__rightBraceLines)
		results = self.__intendWorker(results)
		return results

	@staticmethod
	def preAnalyzer(inputLines):
		currentBrackets = []
		openningBrackets = ["[", "{", "("]
		closingBrackets = ["]", "}", ")"]
		last = list()
		result = True
		for i, line in enumerate(inputLines):
			for j, letter in enumerate(line):
				if letter in openningBrackets:
					last.clear()
					currentBrackets.append(letter)
					last.append(i)
					last.append(j)
				elif letter in closingBrackets:
					pos = closingBrackets.index(letter)
					if ((len(currentBrackets) > 0) and (
							openningBrackets[pos] == currentBrackets[-1])):
						currentBrackets.pop()
					else:
						print("Error in line {}, {}; Wrong bracket".format(i, j))
						print(line.rstrip())
						print("~" * j + '^')
						result = False
		if len(currentBrackets) > 0:
			print("Error in line {}, {}; No closing bracket".format(last[0] + 1, last[1] + 1))
			print(inputLines[last[0]].rstrip())
			print("~" * (last[1]) + '^')
			result = False
		return result


# import os.path

INDENT = 4
LINE_LENGTH = 80

if __name__ == '__main__':
	parser = argparse.ArgumentParser(prog='KotlinPyFormatter', description='Format .')
	parser.add_argument("path", help="Path to Kotlin file")
	parser.add_argument("--output", help="output path")
	parser.add_argument("-i", "--indent", help="Set indent(default=4)", default=4, choices=(2, 4))
	parser.add_argument("-l", "--line", help="Set max line length(default=80)", default=80, choices=(60, 80, 100, 120))
	args = parser.parse_args()

	abspath = os.path.abspath(os.path.expanduser(os.path.expandvars(args.path)))

	absoutput = args.output
	if absoutput is not None:
		absoutput = os.path.abspath(os.path.expanduser(os.path.expandvars(absoutput)))

	with open(abspath, "r") as file:
		fileContent = file.readlines()

	result = KotlinPyFormatter().formatFile(fileContent, INDENT, LINE_LENGTH, False)
	result = '\n'.join(result)

	with open('result.txt', "w") as file:
		file.write(result)
