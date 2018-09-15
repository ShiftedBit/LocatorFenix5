using Toybox.WatchUi;
using Toybox.Graphics as Gfx;

class LocatorGreylineView extends WatchUi.View {

	hidden var screenWidth;
	hidden var screenHeight;
	hidden var screenPercent;

	function initialize() {
		View.initialize();
	}
	
	// Load your resources here
    function onLayout(dc) {
    
		screenWidth = dc.getWidth();
		screenHeight = dc.getHeight();
		screenPercent = screenWidth.toFloat() / 100;

        setLayout(Rez.Layouts.MainLayout(dc));
    }
    
    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	
    	renderGreyline(dc);
        // Call the parent onUpdate function to redraw the layout   
    }
    
    function renderGreyline(dc) {
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(50 * screenPercent, 10 * screenPercent, Gfx.FONT_XTINY, "Greyline View", Gfx.TEXT_JUSTIFY_CENTER);
    }
    
}