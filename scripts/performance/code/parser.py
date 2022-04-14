import json
from pandas import DataFrame, Series
from .diagram_creator import *

def parserPerformanceToConsole(path):
    parseData = json.load(open(path))

    totalTime = parseData["elapsedTime"]
    getFromFolderNameCount = 0
    getFromFolderNameTotalTime = 0
    parsePathCount = 0
    parsePathTotalTime = 0
    parseNameCount = 0
    parseNameTotalTime = 0
    addCategoryCount = 0
    addCategoryTotalTime = 0
    cleanFileNameCount = 0
    cleanFileNameTotalTime = 0

    for point in parseData["childs"]:
        if point["key"] == "getFromFolderName":
            getFromFolderNameCount = getFromFolderNameCount + 1
            getFromFolderNameTotalTime = getFromFolderNameTotalTime + point["elapsedTime"] 
        if point["key"] == "parsePath" :
            parsePathCount = parsePathCount + 1
            parsePathTotalTime = parsePathTotalTime + point["elapsedTime"]
        if point["key"] == "parseName":
            parseNameCount = parseNameCount + 1
            parseNameTotalTime = parseNameTotalTime + point["elapsedTime"]
        if point["key"] == "addCategory":
            addCategoryCount = addCategoryCount + 1
            addCategoryTotalTime = addCategoryTotalTime + point["elapsedTime"]
        if point["key"] == "cleanFileName":
            cleanFileNameCount = cleanFileNameCount + 1
            cleanFileNameTotalTime = cleanFileNameTotalTime + point["elapsedTime"]

    parsePathPercentage = parsePathTotalTime / totalTime
    getFromFolderPercentage = getFromFolderNameTotalTime / totalTime
    parseNamePercentage = parseNameTotalTime / totalTime
    cleanFileNamePercentage = cleanFileNameTotalTime / totalTime
    addCategoryPercentage = addCategoryTotalTime / totalTime
    
    percentage = [getFromFolderPercentage, parseNamePercentage, \
        cleanFileNamePercentage, addCategoryPercentage]
    labels = ["Get From Folder", "Parse Name", "Clean File Name", "Add Category"]
        
    print(f"Tree Parser took {totalTime / 1000000} seconds to parse {parsePathCount} files")
    print(f"\tparsePath function used {parsePathPercentage}%, but it is the top function so it makes sense")
    print(f"\tgetFromFolderName function used {getFromFolderPercentage}% and was called {getFromFolderNameCount} times")
    print(f"\tparseName function used {parseNamePercentage}% and was called {parseNameCount} times")
    print(f"\tcleanFileName function used {cleanFileNamePercentage}% and was called {cleanFileNameCount} times")
    print(f"\taddCategoryTotalTime function used {addCategoryPercentage}% and was called {addCategoryCount} times")

    createPieChart(percentage, labels, "Percentage of time used in parser", "img/parse_percentagev0.1.png")
