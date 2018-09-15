using Toybox.WatchUi;
using Toybox.Position as Pos;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;

class LocatorView extends WatchUi.View {

	hidden var posInfo;
	hidden var screenWidth;
	hidden var screenHeight;
	hidden var screenPercent;
	hidden var locatorConverter;
	hidden var gpsQuality;

    function initialize() {
    
    	gpsQuality = {
    		0 => "not available",
    		1 => "last known location",
    		2 => "poor",
    		3 => "usable",
    		4 => "good"
    	};
    
    	locatorConverter = new LocatorConverter();
    	Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    
		screenWidth = dc.getWidth();
		screenHeight = dc.getHeight();
		screenPercent = screenWidth.toFloat() / 100;

        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	
    	renderLocator(dc);
        // Call the parent onUpdate function to redraw the layout
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function onPosition(info) {
    
    	if (info) {
    		posInfo = info;
    	} else {
    		posInfo = null;
    	}
    
    	posInfo = info;
    	Ui.requestUpdate();
    }
    
    function renderLocator(dc) {
    
    	var locator;
    	var utc = Gregorian.utcInfo(Time.now(), Time.FORMAT_MEDIUM);
    	var myTime = Lang.format(
	    		"$1$:$2$:$3$",
	   			[utc.hour.format("%02d"), utc.min.format("%02d"), utc.sec.format("%02d")]
   			);
		
		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    
    	if (posInfo) {
			
			var accuracy = gpsQuality[posInfo.accuracy];   	
    		locatorConverter.updateWithPosition(posInfo);
    		locator = locatorConverter.getLocator();
    		
    		//System.println(locatorConverter.getHeading());
    		
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 10 * screenPercent, Gfx.FONT_XTINY, "UTC Time", Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 20 * screenPercent, Gfx.FONT_SMALL, myTime, Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 35 * screenPercent, Gfx.FONT_XTINY, "Your Locator", Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 45 * screenPercent, Gfx.FONT_LARGE, locator, Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 65 * screenPercent, Gfx.FONT_XTINY, "GPS Accuracy", Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 75 * screenPercent, Gfx.FONT_XTINY, accuracy, Gfx.TEXT_JUSTIFY_CENTER);
    		
    	} else {
    		dc.clear();
    		
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 30 * screenPercent, Gfx.FONT_XTINY, "HAM Dashboard", Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 50 * screenPercent, Gfx.FONT_LARGE, "Waiting for GPS", Gfx.TEXT_JUSTIFY_CENTER);
    		
    		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(50 * screenPercent, 80 * screenPercent, Gfx.FONT_XTINY , "by OE1MAX", Gfx.TEXT_JUSTIFY_CENTER);
    	}
    
    	
    }
    

}
