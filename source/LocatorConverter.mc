using Toybox.Math;

class LocatorConverter {

	private var _position;
	private var _heading;
	
	
	function initialize() {
	}
	
	function updateWithPosition(position) {
		_position = position.position;
		_heading = position.heading;
	}
	
	function getLocator() {
	
		if (_position == null) {
			return false;
		}
	
		var lat = _position.toDegrees()[0].toFloat();
		var lng = _position.toDegrees()[1].toFloat();
		
		var locatorArray = [];
		
		var long_mh=lng+180;                           		//dcallage de la grille
		var lat_mh=lat+90;
		
		var digit1=Math.floor(long_mh/20)+1;           		//1er digit (tranche de 20 degrs longitude)
		var char1=char(digit1+64);
		locatorArray.add(char1);
		
		var digit2=Math.floor(lat_mh/10)+1;            		//2me digit (tranche de 10 degrs latitude)
		var char2=char(digit2+64);                    		//conversion en alphabtique
		locatorArray.add(char2);
		
		var digit3=Math.floor(fmod(long_mh,20)/2);      		//3me digit (tranche de 2 degr longitude)
		locatorArray.add(digit3.toLong());
		
		var digit4=Math.floor(fmod(lat_mh,10)/1);       		//4me digit (tranche de 1 degr latitude)
		locatorArray.add(digit4.toLong());
		
		var digit5=Math.floor(fmod(long_mh,2)*60/5)+1;  		//%5me digit (tranche de 5 minutes d'arc longitude)
		var char5=char(digit5+64);                      	//conversion en alphabtique
		locatorArray.add(char5);
		
		var digit6=Math.floor(fmod(lat_mh,1)/1*60/2.5)+1; 	//6me digit (tranche de 2.5 minutes d'arc latitude)
		var char6=char(digit6+64);                      	//conversion en alphabtique
		locatorArray.add(char6);
		
		return Lang.format("$1$$2$$3$$4$$5$$6$", locatorArray);
		
	}
	
	function char(num) {
        // Limitation: Need supported escape sequences for " and %
        var ASCII = " ! #$ &'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
        var char = "";

        if(num >= 32 && num <= 126) {
            char = ASCII.substring(num - 32, num - 32 + 1);
        }

        return(char);
    }
    
    function fmod(a, b) {
    	return (a - b * Math.floor(a / b));
    }
	
}