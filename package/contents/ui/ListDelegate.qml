import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls as QQC2
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

Item {
  id: item

  signal clicked
  signal iconClicked

  property alias text: label.text
  property alias containsMouse: area.containsMouse
  property bool hovered: false

  Layout.fillWidth: true
  implicitHeight: plasmoid.configuration.buttonHeight

  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true
    onClicked: item.clicked()
    onEntered: item.hovered = true
    onExited: item.hovered = false
  }

  RowLayout {
    id: row
    anchors.centerIn: parent
    width: parent.width - Kirigami.Units.smallSpacing
    spacing: Kirigami.Units.smallSpacing

    PlasmaComponents.Label {
      id: label
      Layout.fillWidth: true
      wrapMode: Text.NoWrap
      elide: Text.ElideRight
      padding: 5
    }
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    visible: hovered
    z: -1

    PlasmaExtras.Highlight {
      anchors.fill: parent
      hovered: true
    }
  }
}
 
