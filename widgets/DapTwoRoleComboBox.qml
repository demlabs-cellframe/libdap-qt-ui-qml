import QtQuick 2.4
import QtQuick.Controls 2.0

DapTwoRoleComboBoxForm
{
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

                        property int comboBoxIndex: index
                        property int comboBoxCurrentIndex: currentIndex

                        Row
                        {
                            id: textRow
                            width: rectangleTextComboBox.width - ((index != currentIndex) ?
                                                                      endRowPadding :
                                                                      (indicatorWidth + indicatorLeftInterval)
                                                                  )
                            height: rectangleTextComboBox.height
                            spacing: roleInterval

                            Repeater
                            {
                                id: textRepeater
                                model: 2

                                DapText
                                {
                                    id: textComboBoxDelegate
                                    width: (textRow.width - roleInterval) / 2
                                    enabled: false
                                    fontDapText: index === 0 ? textFont : secondTextFont
                                    textColor: hovered ?
                                                   (index === 0 ? hilightColorText : hilightColorSecondText) :
                                                   (index === 0 ? normalColorText : normalColorSecondText)
                                    fullText: getModelData(rectangleTextComboBox.comboBoxIndex, (index === 0 ? firstTextRole : secondTextRole))
                                    textElide: index === 0 ?
                                                   (isFirstElided ? Text.ElideRight : Text.ElideNone) :
                                                   (isFirstElided ? Text.ElideNone : Text.ElideMiddle)
                                    horizontalAlignment: index === 0 ? Text.AlignLeft : Text.AlignRight

                                    Component.onCompleted:
                                    {
                                        updateMainRow(dapComboBoxFontMetric, rectangleTextComboBox.comboBoxIndex, rectangleTextComboBox.comboBoxCurrentIndex, textComboBoxDelegate.width)
                                    }

                                }

                            }

                        }
                        Component.onCompleted:
                        {
                            if(rectangleTextComboBox.comboBoxCurrentIndex !== -1)
                                updateMainRow(dapComboBoxFontMetric, rectangleTextComboBox.comboBoxIndex, rectangleTextComboBox.comboBoxCurrentIndex, (textRow.width - roleInterval) / 2);

                        }
                        onComboBoxCurrentIndexChanged:
                        {
                            if(rectangleTextComboBox.comboBoxCurrentIndex !== -1)
                                updateMainRow(dapComboBoxFontMetric, rectangleTextComboBox.comboBoxIndex, rectangleTextComboBox.comboBoxCurrentIndex, (textRow.width - roleInterval) / 2);

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

    //For update text at mainLine of comboBox
    function updateMainRow(fm, cbIndex, cbCurrentIndex, width)
    {
        if(cbIndex === cbCurrentIndex)
        {
            dapComboBoxTextMetric.font = textFont
            mainLineText = fm.elidedText(getModelData(cbCurrentIndex, firstTextRole), (isFirstElided ? Text.ElideRight : Text.ElideNone), width, Qt.TextShowMnemonic);

            dapComboBoxTextMetric.font = secondTextFont
            mainLineSecondText = fm.elidedText(getModelData(cbCurrentIndex, secondTextRole), (isFirstElided ? Text.ElideNone : Text.ElideMiddle), width, Qt.TextShowMnemonic);

        }

    }

}
