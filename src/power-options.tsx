import { promises } from "fs";
import os from "os";
import { Action, ActionPanel, closeMainWindow, Icon, List } from "@vicinae/api";

type Command = {
  name: string;
  description: string;
  icon: Icon;
  command: "lock" | "logout" | "suspend" | "reboot" | "poweroff";
};

const commands: Command[] = [
  {
    name: "Lock",
    description: "Lock the screen",
    icon: Icon.Lock,
    command: "lock",
  },
  {
    name: "Log Out",
    description: "Log out of your session",
    icon: Icon.Logout,
    command: "logout",
  },
  {
    name: "Suspend",
    description: "Suspend the system",
    icon: Icon.Moon,
    command: "suspend",
  },
  {
    name: "Reboot",
    description: "Restart the system",
    icon: Icon.RotateClockwise,
    command: "reboot",
  },
  {
    name: "Power Off",
    description: "Shut down the system",
    icon: Icon.Power,
    command: "poweroff",
  },
];

export default function PowerOptions() {
  const runCommand = async (cmd: Command) => {
    closeMainWindow();

    const homeDir = os.homedir(); // get user home directory (/home/...)
    const SOCKET = `${homeDir}/.local/share/vicinae-power-menu/helper.sock`; // assuming the FIFO is stored here
    
    try {
      await promises.writeFile(SOCKET, `${cmd.command}\n`);
    } catch (err) {
      console.error(`${cmd.name} failed:`, err);
    }
  };

  return (
    <List searchBarPlaceholder="Select a power option...">
      {commands.map((cmd) => (
        <List.Item
          key={cmd.name}
          title={cmd.name}
          subtitle={cmd.description}
          icon={cmd.icon}
          actions={
            <ActionPanel>
              <Action title="Execute" onAction={() => runCommand(cmd)} />
            </ActionPanel>
          }
        />
      ))}
    </List>
  );
}
