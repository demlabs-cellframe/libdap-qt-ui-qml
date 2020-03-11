import QtQuick 2.4

DapAbstractComboBox
{
    id: dapSimpleComboBox

    //Text item
    contentItem:
        Rectangle
        {
            id: mainRectangle
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
            color: "transparent"

            Text
            {
                id: cmbBxMainItemText
                width: widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval)
                anchors.verticalCenter: parent.verticalCenter
                enabled: false
                text: mainLineText
                font: textFont
                color: popup.visible ? hilightColorTopText : normalColorTopText
                horizontalAlignment: Text.AlignLeft
                clip: true
            }
        }
}
