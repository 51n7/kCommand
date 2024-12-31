import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kirigami as Kirigami

PlasmoidItem  {
  id: root
  
  property string icon: plasmoid.configuration.icon
  property var cmdList: plasmoid.configuration.cmdList
  property var limit: plasmoid.configuration.listLimit

  Plasmoid.icon: icon

  Plasma5Support.DataSource {
    id: executable
    engine: "executable"
    connectedSources: []
    onNewData: (sourceName) => disconnectSource(sourceName)

    function exec(cmd) {
      executable.connectSource(cmd)
    }
  }

  Component.onCompleted: {
    cmdList = cmdList.slice(0, limit);
  }

  fullRepresentation: Item {
    Layout.preferredWidth: plasmoid.configuration.width
    Layout.preferredHeight: columm.implicitHeight
    Layout.minimumWidth: Layout.preferredWidth
    Layout.maximumWidth: Layout.preferredWidth
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight

    ColumnLayout {
      id: columm
      anchors.fill: parent
      spacing: 0

      TextField {
        id: inputField
        placeholderText: 'command'
        Layout.fillWidth: true
        onAccepted: {
          cmdList.unshift(inputField.text); // add command to start of list

          cmdList = cmdList.slice(0, limit); // using slice to ensure extra items are trimed when limit changes
          plasmoid.configuration.cmdList = cmdList;

          inputField.text = ''
        }
      }

      Repeater {
        model: cmdList

        ColumnLayout {
          ListDelegate {
            text: i18n(modelData)
            onClicked: executable.exec(cmdList[index])
          }
        }
      }
    }
  }
}
