import json
import os

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
    totalPercentage = [extractionPercentage, parsingPercentage]
    # totalLabels

    # decodePercentage = 
    # extractPercentage =
    # extractSeries =

    print(f"Extraction and parsing took {totalTime / 100000} seconds")
    print(f"\tWith extraction taking {extractionPercentage}% of the time, with")
    print(f"\t\tDecoding of zip taking {decodeZipTime / extractTotalTime * 100}% of the extraction time")
    print(f"\t\tExtraction of file taking {extractedFileTime / extractTotalTime * 100}% of the extraction time")
    print(f"\tAnd parsing taking {parsingPercentage}% of the time, with")
    print(f"\t\tParsing of file taking {parseOfFileTme / parseTime * 100}% of the parse time")