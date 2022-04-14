import os
import code.image_tagging as it
import code.image_classify as ic
import code.parser as p
import code.sentiment as s
import code.extract as e

folderInsta = os.path.join("readings", "Instagram");
folderFacebook = os.path.join("readings", "Facebook");
saveInsta = os.path.join("img", "Instagram")
saveFacebook = os.path.join("img", "Facebook")

extractDataNewInsta = os.path.join(folderInsta, "1649919884197626-Extraction and parsing.json")
parserDataNewInsta = os.path.join(folderInsta, "1649919884192624-Tree Parser Performance Data.json") 
# sentimentDataOldInsta = os.path.join(folderInsta, "1649760401279386-Sentiment classification.json")
sentimentDataNewInsta = os.path.join(folderInsta, "1649919895180558-Sentiment classification.json")
imageDataNewInsta = os.path.join(folderInsta, "1649927778577750-Tagging of images only total.json")
imageClassInsta = os.path.join(folderInsta, "1649927778564748-Image Classifier Abstract Class.json")

extractDataNewFacebook = os.path.join(folderFacebook, "1649922014370244-Extraction and parsing.json")
parserDataNewFacebook = os.path.join(folderFacebook, "1649922014345243-Tree Parser Performance Data.json") 
# sentimentDataOldFacebook = os.path.join(folderFacebook, "1649760401279386-Sentiment classification.json")
sentimentDataNewFacebook = os.path.join(folderFacebook, "1649922245262247-Sentiment classification.json")
imageDataNewFacebook = os.path.join(folderFacebook, "1649928298832161-Tagging of images only total.json")
imageClassFacebook = os.path.join(folderFacebook, "1649928298821161-Image Classifier Abstract Class.json")

print("########## Instagram ##########")
print("##### Extract - Start #####")
e.extractAndParseReadingToConsole(extractDataNewInsta, os.path.join(saveInsta, "extract_time_percent_v0.1.png"))
print("###### Extract - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserDataNewInsta, os.path.join(saveInsta, "parse_time_percent_v0.1.png"))
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageDataNewInsta, os.path.join(saveInsta, "image_taggin_time_percent_v0.1.png"))
print("###### Image Tagging - End ######\n")

print("##### Image Classifier - Start #####")
ic.classifyPerformanceToConsole(imageClassInsta, os.path.join(saveInsta, "image_classifier_time_percent_v0.1.png"))
print("###### Image Classifier - End ######\n")

# print("##### Sentiment Old - Start #####")
# s.sentimentReadingToConsole(os.path.join(sentimentDataOldInsta, ""))
# print("###### Sentiment Old - End ######\n")

print("##### Sentiment - Start #####")
s.sentimentReadingToConsole(sentimentDataNewInsta, os.path.join(saveInsta, "sentiment_time_percent_v0.1.png"))
print("###### Sentiment - End ######")
print("########## Instagram ##########\n\n")





print("########## Facebook ##########")
print("##### Extract - Start #####")
e.extractAndParseReadingToConsole(extractDataNewFacebook, os.path.join(saveFacebook, "extract_time_percent_v0.1.png"))
print("###### Extract - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserDataNewFacebook, os.path.join(saveFacebook, "parse_time_percent_v0.1.png"))
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageDataNewFacebook, os.path.join(saveFacebook, "image_taggin_time_percent_v0.1.png"))
print("###### Image Tagging - End ######\n")

print("##### Image Classifier - Start #####")
ic.classifyPerformanceToConsole(imageClassFacebook, os.path.join(saveFacebook, "image_classifier_time_percent_v0.1.png"))
print("###### Image Classifier - End ######\n")

# print("##### Sentiment Old - Start #####")
# s.sentimentReadingToConsole(os.path.join(sentimentDataOldInsta, ""))
# print("###### Sentiment Old - End ######\n")

print("##### Sentiment - Start #####")
s.sentimentReadingToConsole(sentimentDataNewFacebook, os.path.join(saveFacebook, "sentiment_time_percent_v0.1.png"))
print("###### Sentiment - End ######")
print("########## Facebook ##########")
