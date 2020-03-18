import QtQuick 2.4
import QtQuick.Controls 2.0

DapOneRoleComboBoxForm
{
    Component.onCompleted:
    {
        if(currentIndex !== -1)
        {
            currentIndex = -1;
            addDefaultValueToModel(oneTextRole);
            currentIndex = 0;
            mainLineText = checkElide(textAt(currentIndex), widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
        }
        else
            mainLineText = checkElide(defaultMainLineText, widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval), Text.ElideRight);
    }

    delegate:
        ItemDelegate
        {
            width: parent.width
            height: getItemHeight(index)

            contentItem:
                    Rectangle
                    {
                        id: rectangleTextComboBox
                        anchors.fill: parent
                        anchors.topMargin: paddingTopItemDelegate
                        anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                        anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                        color: "transparent"
                        DapText
                        {
                            id: cmbBxItemText
                            width: parent.width - ((index != currentIndex) ?
                                                      0 :
                                                      (indicatorWidth + indicatorLeftInterval)
                                                  )
                            height: rectangleTextComboBox.height
                            enabled: false
                            fontDapText: textFont
                            textColor: hovered ? hilightColorText : normalColorText
                            horizontalAlignment: Text.AlignLeft
                            textElide: Text.ElideRight
                            fullText: getModelData(index, oneTextRole)
                            clip: true
                        }

                    }
            background:
                Rectangle
                {
                    anchors.fill: parent
                    anchors.bottomMargin: getBackgroundSize(index)
                    color: hovered ? hilightColor : normalColor
                }

            highlighted: DapAbstractComboBox.highlightedIndex === index
        }

}
