import os
import code.image_tagging as it
import code.image_classify as ic
import code.parser as p
import code.sentiment as s
import code.extract as e

folder = "readings";

extractDataNew = os.path.join(folder, "1649513020605328-Extraction and parsing.json")
parserDataNew = os.path.join(folder, "1649513020596328-Tree Parser Performance Data.json") 
sentimentDataOld = os.path.join(folder, "1649760401279386-Sentiment classification.json")
sentimentDataNew = os.path.join(folder, "1649763465496595-Sentiment classification.json")
imageDataNew = os.path.join(folder, "1649513357444088-Tagging of images only total.json")
imageClass = os.path.join(folder, "1649769941489603-Image Classifier Abstract Class.json")

print("##### Extract - Start #####")
e.extractAndParseReadingToConsole(extractDataNew)
print("###### Extract - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserDataNew)
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageDataNew)
print("###### Image Tagging - End ######\n")

print("##### Image Classifier - Start #####")
ic.classifyPerformanceToConsole(imageClass)
print("###### Image Classifier - End ######\n")

print("##### Sentiment Old - Start #####")
s.sentimentReadingToConsole(sentimentDataOld)
print("###### Sentiment Old - End ######\n")

print("##### Sentiment New - Start #####")
s.sentimentReadingToConsole(sentimentDataNew)
print("###### Sentiment New - End ######\n")
