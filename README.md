# XcodeCareer
    A plug-in for Xcode which can record how much lines and how long you've code.
    Press `Shift + P` to take a look at your achievement.    

## Rules
    1.The plug-in is initialized with `TotalLines` = `TotalSeconds` = 0.
    2.Codes created by Xcode or imported from outside are ignored.
    3.Only those codes which are written by yourself are accumulated.
    4.It means everytime you press 'Enter' and increase a line in Xcode will increase the number of `TotalLines`.
    5.Similarily, everytime you press 'Delete' and remove a lien in Xcode will decrease the number of `TotalLines`.
    6.If you stop coding for more than `5` seconds, the timer will be paused and `TotalSeconds` stops increasing.
    7.When you go on to code, the timer will be recoverd automatically which means `TotalSeconds` increases again.       
## Bugs
    Everytime you run your program、edit another class or press the `Shift + P`.Statistics are stored automatically. 
    This means when you quit Xcode,you may lose data after the latest save.

## New Versioin
    The panel which shows up after pressing `Shift + P` will be re-designed so that it looks better.
    Trace more data.
    Try to encrypt statistics.
