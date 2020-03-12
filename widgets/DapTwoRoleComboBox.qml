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
                            property var elTextArray: []

                            Repeater
                            {
                                id: textRepeater
                                model: comboBoxTextRole.length

                                DapText
                                {
                                    id: textComboBoxDelegate
                                    width: (textRow.width - roleInterval * (comboBoxTextRole.length - 1)) / comboBoxTextRole.length
                                    enabled: false
                                    fontDapText: (fontComboBox.length > index) ?
                                                     fontComboBox[index] :
                                                     fontComboBox[0];
                                    textColor: hovered ? colorTextComboBox[index][1] : colorTextComboBox[index][0]
                                    fullText: getModelData(rectangleTextComboBox.comboBoxIndex, comboBoxTextRole[index])
                                    textElide: (elideTextComboBox.length > index) ?
                                                   elideTextComboBox[index] :
                                                   elideTextComboBox[0];
                                    horizontalAlignment: (alignTextComboBox.length > index) ?
                                                   alignTextComboBox[index] :
                                                   alignTextComboBox[0];
                                    onElTextChanged: textRow.elTextArray[index] = elText

                                    Component.onCompleted:
                                    {
                                        if(rectangleTextComboBox.comboBoxIndex == rectangleTextComboBox.comboBoxCurrentIndex)
                                        {

                                            var tmp = mainRow;
                                            tmp[index] = elText;
                                            mainRow = tmp;

                                            if(index == 0)
                                            {
                                                comboBoxFontMetric.font = (fontComboBox.length > index) ?
                                                          fontComboBox[index] :
                                                          fontComboBox[0];
                                                mainLineText = comboBoxFontMetric.elidedText(fullText, Text.ElideRight, rectangleTextComboBox.width, Qt.TextShowMnemonic);
                                            }
                                        }
                                    }

                                }

                            }

                        }
                        Component.onCompleted:
                        {
                            if(rectangleTextComboBox.comboBoxCurrentIndex !== -1)
                                updateMainRow(comboBoxFontMetric, rectangleTextComboBox.comboBoxIndex, rectangleTextComboBox.comboBoxCurrentIndex, textRow.elTextArray, (widthPopupComboBoxNormal - indicatorWidth - indicatorLeftInterval));

                        }
                        onComboBoxCurrentIndexChanged:
                        {
                            if(rectangleTextComboBox.comboBoxCurrentIndex !== -1)
                                updateMainRow(comboBoxFontMetric, rectangleTextComboBox.comboBoxIndex, rectangleTextComboBox.comboBoxCurrentIndex, textRow.elTextArray, rectangleTextComboBox.width);

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

    function updateMainRow(fm, cbIndex, cbCurrentIndex, elTextArray, width)
    {
        if(cbIndex === cbCurrentIndex)
        {
            for(var i = 0; i < comboBoxTextRole.length; i++)
            {
                fm.font = (fontComboBox.length > i) ?
                            fontComboBox[i] :
                            fontComboBox[0];

                var tmp = mainRow;
                tmp[i] = elTextArray[i];
                mainRow = tmp;

                if(i == 0)
                    mainLineText = fm.elidedText(getModelData(cbCurrentIndex, comboBoxTextRole[0]), Text.ElideRight, width, Qt.TextShowMnemonic);
            }
        }
    }

}
