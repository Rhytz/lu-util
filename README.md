# Liberty Unleashed utility functions
This repository will be a combination of general use functions for Liberty Unleashed (Squirrel script). Place the Rhytz-Utils folder in your Scripts folder and include the necessary files in your scripts using dofile();

###Event functions
The event functions implement an event system similar to the system found in Multi Theft Auto: San Andreas. It allows you to add custom events to your script that other scripts can hook into.

An example best shows how this could be useful:

Your script:
```Squirrel
function onScriptLoad(){
  //Load the events functions
	dofile("Scripts/Rhytz-Util/events_s.nut");
  //Register the event
	addEvent("onSomethingHappened");
}

function somethingHappened(name, message){
  //This function is called for whatever reason in your script
  print("Something happened in this script");
  //Trigger the event
  triggerEvent("onSomethingHappened", myVariable1, myVariable2, "myString"); //etc
}
```

External script:
```Squirrel
function onScriptLoad(){
  //Register myFunction to be called when the event is triggered in the main script
	CallFunc("myscript.nut", "addEventHandler", "externalscript.nut", "onSomethingHappened", "myFunction");
}

function myFunction(myVariable1, myVariable2, myString){
  print("Something happened in the external script");
}

function onScriptUnload(){
  //Remove the function again if the script unloads
	CallFunc("myscript.nut", "removeEventHandler", "externalscript.nut", "onSomethingHappened", "myFunction");
}
```

###Functions

#### addEvent(string eventName)
```Squirrel
function onScriptLoad(){
  addEvent("eventName");
}
```
Registers an with the event system.

Returns 1 if succesfull. Null if the event was already registered.

#### triggerEvent(string eventName, ...)
```Squirrel
function somethingHappened(){
  triggerEvent("eventName", param1, param2, param3); //etc
}
```
Triggers all registered handler functions with given parameters (variable amount of parameters).

Returns 1 if all called functions return something other than null. Returns null if any of the triggered functions return null  (or it no longer exists).

#### addEventHandler(string Path, string Event, string Function)
```Squirrel
function onScriptLoad(){
  CallFunc("myscript.nut", "addEventHandler", "externalscript.nut", "eventName", "myFunction");
}
function myFunction(param1, param2, param3){
  //do something with the values
}
```
Registers a function to be called when eventName is triggered in the source script. To be used in external scripts using CallFunc.

Returns 1 if the function is succesfully registered, null if it was already registered, or the event is undefined in the source script.

#### removeEventHandler(string Path, string Event, string Function)
```Squirrel
function onScriptUnload(){
  CallFunc("myscript.nut", "removeEventHandler", "externalscript.nut", "eventName", "myFunction");
}
```

Removes a function to be called when the event happens. If triggerEvent calls non-existent functions, it will return null. Hence you should remove any functions that will no longer be available. 
