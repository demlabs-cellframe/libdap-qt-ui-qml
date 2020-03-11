import QtQuick 2.4
import QtQuick.Controls 2.0

DapOneRoleComboBoxForm
{
    //To do elide
    TextMetrics
    {
        id: comboBoxTextMetric
        font: textFont
        elide: Text.ElideRight
    }
    // To check elide
    FontMetrics
    {
        id: comboBoxFontMetric
        font: textFont
    }

    Component.onCompleted:
    {
        console.log(getModelData(0, oneTextRole))
        if(model.get(0, oneTextRole) !== defaultMainLineText)
        {
            if(oneTextRole === "name")
                model.insert(0, {name: defaultMainLineText});
            else if(oneTextRole === "text")
                model.insert(0, {text: defaultMainLineText});
        }
        currentIndex = 0;
        comboBoxTextMetric.text = defaultMainLineText;
        comboBoxTextMetric.elideWidth = widthPopupComboBoxNormal - (indicatorWidth + indicatorLeftInterval);
        if(comboBoxTextMetric.elideWidth < comboBoxFontMetric.tightBoundingRect(comboBoxTextMetric.text).width)
            mainLineText = comboBoxTextMetric.elidedText.substring(0, comboBoxTextMetric.elidedText.length - 1) +
                    ((comboBoxFontMetric.tightBoundingRect(comboBoxTextMetric.elidedText.substring(0, comboBoxTextMetric.elidedText.length - 1)).width +
                      comboBoxFontMetric.tightBoundingRect(comboBoxTextMetric.text.charAt(comboBoxTextMetric.elidedText.length - 1) + '..').width) < comboBoxTextMetric.elideWidth ?
                         (comboBoxTextMetric.text.charAt(comboBoxTextMetric.elidedText.length - 1) + '..') :
                       '..');
        else
            mainLineText = comboBoxTextMetric.elidedText.replace('…', '..');

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
