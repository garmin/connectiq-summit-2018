using Toybox.Application;
using Toybox.Graphics;

class InputApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        var aController = new ColorController();
        return aController.getInitialView();
    }
}
