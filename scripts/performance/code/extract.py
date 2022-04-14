import json
import os
from .diagram_creator import *

def extractAndParseReadingToConsole(path):
    extractData = json.load(open(path))

    totalTime = extractData["elapsedTime"]
    childs = extractData["childs"][0]
    extractTotalTime = childs["elapsedTime"]
    decodeZipTime = 0
    extractedFileTime = 0

    for point in childs["childs"]:
        if point["key"] == "Decode of zip":
            decodeZipTime = decodeZipTime + point["elapsedTime"]
        if point["key"] == "Extracted File":
            extractedFileTime = extractedFileTime + point["elapsedTime"]

    childs = extractData["childs"][1]
    parseTime = childs["elapsedTime"]
    parseOfFileTme = 0

    for point in childs["childs"]:
        if point["key"] == "Parse of file":
            parseOfFileTme = parseOfFileTme + point["elapsedTime"]
    
    extractionPercentage = extractTotalTime / totalTime * 100
    parsingPercentage = parseTime / totalTime * 100
    other = 100 - extractionPercentage - parsingPercentage
    totalPercentage = [extractionPercentage, parsingPercentage, other]
    totalLabels = ["Extraction", "Parsing", "Other"]
    # createPieChart(totalPercentage, totalLabels, "Extract and parsing time in percentage", "img/extract_and_parsev0.1.png")

    decodePercentage = decodeZipTime / extractTotalTime * 100
    extractPercentage = extractedFileTime / extractTotalTime * 100
    other = 100 - decodePercentage - extractPercentage
    extractPercentage = [decodePercentage, extractPercentage, other]
    extractLabel = ["Decode", "Extract", "Other"]
    createPieChart(extractPercentage, extractLabel, "Percentage time in extraction", "img/extract_percentagev0.1.png")

    parseFileTime = parseOfFileTme / parseTime * 100
    extractSeries = [parseFileTime]

    print(f"Extraction and parsing took {totalTime / 100000} seconds")
    print(f"\tWith extraction taking {extractionPercentage}% of the time, with")
    print(f"\t\tDecoding of zip taking {decodePercentage}% of the extraction time")
    print(f"\t\tExtraction of file taking {extractionPercentage}% of the extraction time")
    print(f"\tAnd parsing taking {parsingPercentage}% of the time, with")
    print(f"\t\tParsing of file taking {parseFileTime}% of the parse time")