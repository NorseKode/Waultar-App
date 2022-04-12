import os
import code.image_tagging as it
import code.parser as p
import code.sentiment as s
import code.extract as e

folder = "readings";

extractData = os.path.join(folder, "1649513020605328-Extraction and parsing.json")
parserData = os.path.join(folder, "1649513020596328-Tree Parser Performance Data.json") 
sentimentData = os.path.join(folder, "1649513044284718-Sentiment classification.json")
imageData = os.path.join(folder, "1649513357444088-Tagging of images only total.json")

print("##### Extract - Start #####")
e.extractAndParseReadingToConsole(extractData)
print("###### Extract - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserData)
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageData)
print("###### Image Tagging - End ######\n")

print("##### Sentiment - Start #####")
s.sentimentReadingToConsole(sentimentData)
print("###### Sentiment - End ######\n")
