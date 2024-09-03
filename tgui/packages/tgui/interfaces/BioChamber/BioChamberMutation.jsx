import { Box, Button, Dimmer, Icon, Section, Stack } from '../../components';

const GeneticMakeupBuffers = (props) => {
  const elements = [];
  return (
    <Section title="Genetic Makeup Buffers">
      {!!geneticMakeupCooldown && (
        <Dimmer fontSize="14px" textAlign="center">
          <Icon mr={1} name="spinner" spin />
          Genetic makeup transfer ready in...
          <Box mt={1} />
          {geneticMakeupCooldown}s
        </Dimmer>
      )}
      {elements}
    </Section>
  );
};

export const BioChamberMutation = (props) => {
  return (
    <>
      <Stack mb={1}>
        <Stack.Item grow={1} basis={0}>
          <Button>aaa</Button>
        </Stack.Item>
      </Stack>
      <GeneticMakeupBuffers />
    </>
  );
};
