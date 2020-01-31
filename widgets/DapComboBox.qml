import QtQuick 2.4
import QtQuick.Controls 2.0

DapComboBoxForm
{
    delegate:
        ItemDelegate
        {
            width: parent.width

            //Adjusting the height of the line, taking into account that the second element from the end may be the last
            height:
                {
                    if(index != currentIndex)
                    {
                        if(index == (count - 2))
                        {
                            if(index+1 == currentIndex)
                                return heightListElement + bottomIntervalListElement
                            else
                                return heightListElement + intervalListElement
                        }
                        if (index == count - 1)
                            return heightListElement + bottomIntervalListElement
                        return heightListElement + intervalListElement
                    }
                    else return 0
                }

            //Text item
            contentItem:
                Rectangle
                {
                    id: rectTextComboBox
                    anchors.fill: parent
                    anchors.topMargin: paddingTopItemDelegate
                    anchors.leftMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    anchors.rightMargin: popup.visible ? sidePaddingActive : sidePaddingNormal
                    color: "transparent"
                    property int comboBoxIndex: index
                    property int comboBoxCurrentIndex: currentIndex
                    Row
                    {
                        spacing: 20 * pt
                        Repeater
                        {
                            id: rowRepeaterComboBox
                            model: comboBoxTextRole.length
                            Text
                            {
                                id: comboBoxRoleText
                                font: fontComboBox
                                color: hovered ? hilightColorText : normalColorText
                                width: 30
                                //text: getModelData(rectTextComboBox.comboBoxIndex, comboBoxTextRole[index])
                                //Calculates various properties of a given string of text for a particular font
                                TextMetrics
                                {
                                    id: tm
                                    font: fontComboBox
                                    elide: Text.ElideRight
                                    text: getModelData(rectTextComboBox.comboBoxIndex, comboBoxTextRole[index])
                                    elideWidth: comboBoxRoleText.width

                                }
                                FontMetrics
                                {
                                    id: fm
                                    font: fontComboBox
                                }
                                text:
                                    {
                                        //if(index != currentIndex)
                                        //{
                                            if(tm.elidedText.length < tm.text.length)
                                                return tm.elidedText.substring(0, tm.elidedText.length-1) +
                                                        ((fm.tightBoundingRect(tm.elidedText.substring(0, tm.elidedText.length-1)).width +
                                                          fm.tightBoundingRect(tm.text.charAt(tm.elidedText.length-1) + '..').width) < tm.elideWidth ?
                                                             (tm.text.charAt(tm.elidedText.length-1) + '..')
                                                                : '..');
                                            return tm.elidedText.replace('…', '..');
                                       // }
                                       /* else
                                        {
                                            if(tm.elidedText.length < tm.text.length)
                                                mainLineText = tm.elidedText.substring(0, tm.elidedText.length-1) +
                                                        ((fm.tightBoundingRect(tm.elidedText.substring(0, tm.elidedText.length-1)).width +
                                                          fm.tightBoundingRect(tm.text.charAt(tm.elidedText.length-1) + '..').width) < tm.elideWidth ?
                                                             (tm.text.charAt(tm.elidedText.length-1) + '..')
                                                                : '..');
                                            else
                                                mainLineText = tm.elidedText.replace('…', '..');
                                            return "";
                                        }*/
                                    }
                            }
                        }
                        Rectangle
                        {
                            id: endpaddingRectangle
                            width: 44 //endRowPadding
                            height: parent.height
                            color: "yellow"
                        }
                    }
                }



            //Indent from the bottom edge or the next line that will not stand out when you hover over the mouse
            background:
                Rectangle
                {
                    anchors.fill: parent
                    anchors.bottomMargin: {
                        if(index == count - 2)
                        {
                            if(index+1 == currentIndex)
                                return bottomIntervalListElement
                            else
                                return intervalListElement
                        }
                        if (index == count - 1)
                            return bottomIntervalListElement
                        return intervalListElement
                    }
                    color: hovered ? hilightColor : normalColor
                }
            highlighted: parent.highlightedIndex === index
        }

    function getModelData(index, role)
    {
        return model.get(index)[role];
    }
}
