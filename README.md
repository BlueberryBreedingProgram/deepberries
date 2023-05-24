# deepberries
This is the web version of the Blueberry DeepFlavor Sensory Ballot.

The "DeepFlavor" tech stack has several components. "DeepBerries" is the Blueberry Panel Version of the Ballot.
1. A Google Firebase Backend Service, which hosts user responses and generated image files.
2. A Flutter / Dart web implementation, a universal app that can be quickly adapted to web, iOS, Android, native Windows, Mac, etc.
3. GitHub Pages hosting of the front end. The frontend is hosted on a branch called "gh-pages" in this repo, which is live.
4. A series of simple python scripts that perform batch operations on Firebase, converting JSON user responses to CSV, analyzing images with DeepFace, matching user responses, deleting responses. 

A sepreate repo for the backend code will be made availible here: 

# Future Updates
The next step will be to create a friendly web UI for administorators to update sample numbers, update questions, and easily download data. Additionally, to move all image and data processing to the cloud. 

# For external Users
For any other organizations who whish to use a version of this web app there are a few steps that need to be taken:
1. Modify the questions in the dart source code as needed.
2. Initialize your own Firebase server.
3. Update the file "firebase_options.dart" with your firebase information.




