import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

///This file will be moved to libdap and removed from here.
///this comboBox used int top panel exchange and statusBar will be deleted in the future
///About property
/// hilightColor - color of the selected item
/// fontSizeComboBox - font size for the entire widget
///widthPopupComboBoxActive and widthPopupComboBoxNormal - width of the combo box
///                                                 in the active state and in the normal state
///spacingEdgeActive and spacingEdgeNormal - padding width of the combo box in the active state
///                                                                     and in the normal state
ComboBox {
    property string normalColorText: "#070023"
    property string hilightColorText: "#FFFFFF"
    property string normalColor: "#FFFFFF"
    property string hilightColor: "#330F54"
    property int fontSizeComboBox: 16*pt
    property int widthPopupComboBoxActive: parent.width
    property int widthPopupComboBoxNormal: parent.width
    property int spacingEdgeActive:16 * pt
    property int spacingEdgeNormal:16 * pt


    id: customComboBox
    width: popup.visible ? widthPopupComboBoxActive : widthPopupComboBoxNormal
    height: parent.height

    delegate:DapComboBoxDelegate{delegateContentText: modelData;}

    indicator: Image {    
        source: parent.popup.visible ? "qrc:/res/icons/ic_arrow_drop_up_dark_blue.png" : "qrc:/res/icons/ic_arrow_drop_down_dark_blue.png"
        width: 24 * pt
        height: 24 * pt
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: popup.visible ? spacingEdgeActive : spacingEdgeNormal
    }

    background: Rectangle {
        anchors.fill: parent
        color: parent.popup.visible ? normalColor : "transparent"
        radius: 2 * pt
        height: parent.height

    }

    contentItem: Text {
        anchors.fill: parent
        anchors.leftMargin: popup.visible ? spacingEdgeActive : spacingEdgeNormal
        anchors.topMargin: 12 * pt
        text: parent.displayText
        font.family: fontRobotoRegular.name
        font.pixelSize: fontSizeComboBox
        color: normalColorText
        verticalAlignment: Text.AlignTop
    }

    popup: Popup {
        y: parent.height - 1
        width: parent.width + 1
        padding: 1
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: customComboBox.popup.visible ? customComboBox.delegateModel : null
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            width: customComboBox.background.width
            Rectangle {
                id: contentCorner
                anchors.fill: parent
            }

            DropShadow {
                anchors.fill: parent
                source: contentCorner
                verticalOffset: 9 * pt
                samples: 13 * pt
                color: "#40000000"
            }
        }
    }

    DropShadow {
        anchors.fill: parent
        source: background
        verticalOffset: 9 * pt
        samples: 13 * pt
        color: "#40000000"
    }
}
