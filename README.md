# macOCR
A simple macOS command line tool for reading text from images.

# Requirements
To run OCR on all of the supported languages below: macOS 11.0+ \
To run OCR on just English: macOS 10.15+

# Supported Languages
["en-US", "fr-FR", "it-IT", "de-DE", "es-ES", "pt-BR", "zh-Hans", "zh-Hant"] \
English, French, Italian, German, Spanish, Portuguese, Chinese-Simplified, Chinese-Traditional

# How to Run
Step 1: Download the Unix script in the release section on github. \
Step 2: In Terminal, change the permission to be executable by navigating to the folder where the script was downloaded and run the following: 
        chmod +x macOCR \
Step 3: To run the script, run the following: ./macOCR [filepath_to_image] [language_optional] \
        For example: \
        "./macOCR ./1.jpg" will use the default English OCR to analyze the file 1.jpg in the same folder as the script. \
        "./macOCR ./1.jpg zh-Hant" will use the Chinese OCR to analyze the file 1.jpg in the same folder as the script. \
Step 4: If the script does not run, go to System Preferences -> Security & Privacy -> General -> Open Anyway. Then, try step 3 again.

# Sample Output

![Sample](test.jpg)

Recognized text: \
["HELLO WORLD"] \
Normalized bounding box: \
[(0.4765024185180664, 0.4225632985432942, 0.2846009254455566, 0.0780948215060765)] \
Confidence: \
[0.3] 
