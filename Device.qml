import QtQuick 2.0
import QtQuick.Window 2.0


Item {
    id: dapDevice

    property string device: dp()
    property int ppi: Screen.pixelDensity*25.4


    function dp()
    {
        if(ppi>=540)
        {
            device = "mobile"
        }
        else if(ppi>=360)
        {
            device = "mobile"
        }
        else if(ppi>=270)
        {
            device = "mobile"
        }
        else if(ppi>=180)
        {
            device = "mobile"
        }
        else if(ppi>=135)
        {
            device = "desktop"
        }
        else if(ppi < 120)
        {
            device = "desktop"
        }
    }
}
