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

extractionTitle = "Extraction and Parsing Percent Time Used"

extractDataNewInsta = os.path.join(folderInsta, "Extraction and parsing.json")
parserDataNewInsta = os.path.join(folderInsta, "Tree Parser Performance Data.json")
# sentimentDataOldInsta = os.path.join(folderInsta, "1649760401279386-Sentiment classification.json")
sentimentDataNewInsta = os.path.join(folderInsta, "Sentiment classification.json")
sentimentTranslateDataNewInsta = os.path.join(folderInsta, "translate-Sentiment classification.json")
imageDataNewInsta = os.path.join(folderInsta, "Tagging of images only total.json")
imageClassInsta = os.path.join(folderInsta, "Image Classifier Abstract Class.json")

extractBigDataNewFacebook = os.path.join(folderFacebook, "Extraction and parsing.json")
extractSmallDataNewFacebook = os.path.join(folderFacebook, "fs-Extraction and parsing.json")
parserDataNewFacebook = os.path.join(folderFacebook, "Tree Parser Performance Data.json")
# sentimentDataOldFacebook = os.path.join(folderFacebook, "1649760401279386-Sentiment classification.json")
sentimentDataNewFacebook = os.path.join(folderFacebook, "Sentiment classification.json")
imageDataNewFacebook = os.path.join(folderFacebook, "Tagging of images only total.json")
imageClassFacebook = os.path.join(folderFacebook, "Image Classifier Abstract Class.json")

print("########## NOTE: All Run On 1 Isolate ##########")
print("########## Instagram ##########")
print("##### Extract Small - Start #####")
e.extractAndParseReadingToConsole(extractDataNewInsta, os.path.join(saveInsta, "insta_small_extract_time_percent_v0.1.png"), extractionTitle + "\nSingle Thread Instagram Small")
print("###### Extract Small - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserDataNewInsta, os.path.join(saveInsta, "insta_parse_time_percent_v0.1.png"))
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageDataNewInsta, os.path.join(saveInsta, "insta_image_taggin_time_percent_v0.1.png"))
print("###### Image Tagging - End ######\n")

print("##### Image Classifier - Start #####")
ic.classifyPerformanceToConsole(imageClassInsta, os.path.join(saveInsta, "insta_image_classifier_time_percent_v0.1.png"))
print("###### Image Classifier - End ######\n")

# print("##### Sentiment Old - Start #####")
# s.sentimentReadingToConsole(os.path.join(sentimentDataOldInsta, ""))
# print("###### Sentiment Old - End ######\n")

print("##### Sentiment No Translate - Start #####")
s.sentimentReadingToConsole(sentimentDataNewInsta, os.path.join(saveInsta, "insta_sentiment_time_percent_v0.1.png"))
print("###### Sentiment No Translate - End ######")

print("##### Sentiment Translate - Start #####")
s.sentimentReadingToConsole(sentimentDataNewInsta, os.path.join(saveInsta, "insta_translate_sentiment_time_percent_v0.1.png"))
print("###### Sentiment Translate - End ######")
print("########## Instagram ##########\n\n")





print("########## Facebook ##########")
print("##### Extract Big - Start #####")
e.extractAndParseReadingToConsole(extractBigDataNewFacebook, os.path.join(saveFacebook, "facebook_big_extract_time_percent_v0.1.png"), extractionTitle + "\nSingle Thread Facebook Big")
print("###### Extract Big - End ######\n")

print("##### Extract Small - Start #####")
e.extractAndParseReadingToConsole(extractSmallDataNewFacebook, os.path.join(saveFacebook, "facebook_small_extract_time_percent_v0.1.png"), extractionTitle + "\nSingle Thread Facebook Small")
print("###### Extract Small - End ######\n")

print("##### Parser - Start #####")
p.parserPerformanceToConsole(parserDataNewFacebook, os.path.join(saveFacebook, "facebook_parse_time_percent_v0.1.png"))
print("###### Parser - End ######\n")

print("##### Image Tagging - Start #####")
it.taggedImageReadingToConsole(imageDataNewFacebook, os.path.join(saveFacebook, "facebook_image_taggin_time_percent_v0.1.png"))
print("###### Image Tagging - End ######\n")

print("##### Image Classifier - Start #####")
ic.classifyPerformanceToConsole(imageClassFacebook, os.path.join(saveFacebook, "facebook_image_classifier_time_percent_v0.1.png"))
print("###### Image Classifier - End ######\n")

# print("##### Sentiment Old - Start #####")
# s.sentimentReadingToConsole(os.path.join(sentimentDataOldInsta, ""))
# print("###### Sentiment Old - End ######\n")

print("##### Sentiment - Start #####")
s.sentimentReadingToConsole(sentimentDataNewFacebook, os.path.join(saveFacebook, "facebook_sentiment_time_percent_v0.1.png"))
print("###### Sentiment - End ######")
print("########## Facebook ##########")
print("########## NOTE: All Run On 1 Isolate ##########")
