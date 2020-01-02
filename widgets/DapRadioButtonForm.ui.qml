import QtQuick 2.0
import QtQuick.Controls 2.0

RadioButton
{
    ///@detalis textButton Text RadioButton.
    property alias nameRadioButton: nameButton.text
    ///@detalis nameTextColor Text color.
    property alias nameTextColor: nameButton.color
    ///@detalis nameTextPixelSize Text size(px).
    property alias nameTextPixelSize: nameButton.font.pixelSize
    ///@detalis widthRadioButton Width RadioButton.
    property alias widthRadioButton: customRadioButton.implicitWidth
    ///@detalis heightRadioButton Height RadioButton.
    property alias heightRadioButton: customRadioButton.implicitHeight
    ///@detalis backgroundColor RadioButton background color
    property alias backgroundColor:backgroundColor.color
    ///@detalis spaceIndicatorText The gap between the indicator and the text.
    property int spaceIndicatorText: 15 * pt
    ///@detalis indicatorBorderColor Border color indicator.
    property string indicatorBorderColor:"#3E3853"
    ///@detalis indicatorBackgroundColor Background color indicator.
    property string indicatorBackgroundColor:"transparent"
    ///@detalis indicatorInnerColorActiv Color of the inner circle in checked condition.
    property string indicatorInnerColorActiv:indicatorBorderColor
    ///@detalis indicatorInnerColorNormal Color of the inner circle in normal condition.
    property string indicatorInnerColorNormal:indicatorBackgroundColor
    ///@detalis indicatorSize The size of the main circle of the indicator.
    property int indicatorSize: 25 * pt
    ///@detalis indicatorInnerSize The size of the inner circle of the indicator.
    property int indicatorInnerSize: 15 * pt

    id: customRadioButton

    ///Text Options.
    contentItem: Text {
        id: nameButton
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: customRadioButton.indicator.width + spaceIndicatorText
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#3E3853"
        font.pixelSize: 16 * pt
        font.family: "Roboto"
        horizontalAlignment: Text.AlignLeft
        text: qsTr("template")
    }
        ///Indicator Options.
        indicator: Rectangle {
            id: indicatorRadioButton
            implicitWidth: indicatorSize
            implicitHeight: indicatorSize
            x: 0
            y: parent.height / 2 - height / 2
            radius: indicatorSize/2
            color: indicatorBackgroundColor
            border.color: indicatorBorderColor

            ///Indicator inner options.
            Rectangle {
                width: indicatorInnerSize
                height: indicatorInnerSize
                x: (indicatorRadioButton.width/2)-(width/2)
                y: (indicatorRadioButton.height/2)-(height/2)
                radius: indicatorInnerSize/2
                color: customRadioButton.checked ? indicatorInnerColorActiv : indicatorInnerColorNormal
            }
        }
    ///Background options.
    background: Rectangle
    {
        id:backgroundColor
        anchors.fill:parent
        color:"transparent"
    }

    checked: false
    autoExclusive: true
}
