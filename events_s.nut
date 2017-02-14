RegisteredEventCalls <- {};

function addEvent(event){
	if(!RegisteredEventCalls.rawin(event)){
		RegisteredEventCalls[event] <- [];
		return 1;
	}
	return null;
}

function triggerEvent(event, ...){
	local isCancelled = null;
	if(RegisteredEventCalls.rawin(event)){
		foreach(i, EventData in RegisteredEventCalls[event]){
			local paramsArray = [getroottable(), EventData.path, EventData.func];
			paramsArray.extend(vargv);
			if(!::CallFunc.acall(paramsArray)){
				isCancelled = true;
			}
		}
		if(!isCancelled){
			return 1;
		}
	}
	return null;
}

function addEventHandler(path, event, func){
	assert(typeof(path) == "string" && typeof(event) == "string" && typeof(func) == "string");
	local funcdata = { path = path, func = func };
	if(RegisteredEventCalls.rawin(event)){		
		local match = null;
		foreach(RegisteredEventCall in RegisteredEventCalls[event]){
			if(RegisteredEventCall.path == path && RegisteredEventCall.func){
				match = true;
				break;
			}
		}
		if(!match){			
			RegisteredEventCalls[event].push(funcdata);
			return 1;
		}
	}
	return null;
}

function removeEventHandler(path, event, func){
	assert(typeof(path) == "string" && typeof(event) == "string" && typeof(func) == "string");
	local funcdata = { path = path, func = func };
	if(RegisteredEventCalls.rawin(event)){
		foreach(i, RegisteredEventCall in RegisteredEventCalls[event]){
			if(RegisteredEventCall.path == path && RegisteredEventCall.func){
				RegisteredEventCalls[event].remove(i);
				return 1;
			}
		}	
	}
	return null;
}