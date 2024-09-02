import { useBackend } from '../../backend';
import { Box, Button, LabeledList, Section, Stack } from '../../components';
import { Window } from '../../layouts';
import { BioChamberMutation } from './BioChamberMutation';
import { CONSOLE_MODE_MUTATION } from './constants';

export const BioChamber = (props) => {
  const { data } = useBackend();
  const { consoleMode } = data.view;

  return (
    <Window title="Bio Chamber" width={539} height={710}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <BioChamberCommands />
          </Stack.Item>
          <Stack.Item grow>
            {consoleMode === CONSOLE_MODE_MUTATION && <BioChamberMutation />}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const BioChamberCommands = (props) => {
  const { data, act } = useBackend();
  const { consoleMode } = data.view;

  return (
    <Section
      title="Bio Chamber Modes" // SubSection Title
      buttons={
        <Box lineHeight="20px" color="label">
          Injector on cooldown
        </Box>
      }
    >
      <LabeledList>
        <LabeledList.Item label="Mode">
          <Button
            content="Mutations"
            selected={consoleMode === CONSOLE_MODE_MUTATION}
            onClick={() =>
              act('set_view', {
                consoleMode: CONSOLE_MODE_MUTATION,
              })
            }
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
