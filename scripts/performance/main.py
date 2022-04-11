import os
import code.image_tagging as it
import code.parser as p
import code.sentiment as s

folder = "readings";

parserData = os.path.join(folder, "1649508238561-Tree Parser Performance Data.json") 
extractData = os.path.join(folder, "1649508238561-Tree Parser Performance Data.json")
sentimentData = os.path.join(folder, "1649513044284718-Sentiment classification.json")
imageData = os.path.join(folder, "1649508359604-Tagging of images only total.json")


# print("##### Parser - Start #####")
# p.parserPerformanceToConsole(imageData)
# print("###### Parser - End ######\n")

# print("##### Image Tagging - Start #####")
# it.taggedImageReadingToConsole(imageData)
# print("###### Image Tagging - End ######\n")

print("##### Sentiment - Start #####")
s.sentimentReadingToConsole(sentimentData)
print("###### Sentiment - End ######\n")
