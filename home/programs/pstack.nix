{ config, lib, ... }:
let
  cfg = config.programs.pstack;
  skills = [
    "architect"
    "arena"
    "automate-me"
    "blast-radius"
    "bro"
    "create-verification-skill"
    "figure-it-out"
    "how"
    "interrogate"
    "maintain-verification-skill"
    "make-bot-ui"
    "no-comments"
    "poteto-mode"
    "principle-attack-the-premise"
    "principle-boundary-discipline"
    "principle-build-the-lever"
    "principle-encode-lessons-in-structure"
    "principle-exhaust-the-design-space"
    "principle-experience-first"
    "principle-fix-root-causes"
    "principle-foundational-thinking"
    "principle-guard-the-context-window"
    "principle-laziness-protocol"
    "principle-make-operations-idempotent"
    "principle-migrate-callers-then-delete-legacy-apis"
    "principle-minimize-reader-load"
    "principle-model-the-domain"
    "principle-never-block-on-the-human"
    "principle-outcome-oriented-execution"
    "principle-prove-it-works"
    "principle-redesign-from-first-principles"
    "principle-separate-before-serializing-shared-state"
    "principle-sequence-verifiable-units"
    "principle-subtract-before-you-add"
    "principle-test-behavior-not-implementation"
    "principle-type-system-discipline"
    "recall"
    "reflect"
    "setup-pstack"
    "show-me-your-work"
    "swarm"
    "tdd"
    "teach"
    "technical-writing"
    "typescript-best-practices"
    "unslop"
    "why"
  ];
  agents = [ "pstack-reader" "pstack-investigator" "poteto-agent" "pstack-worker" ];
  links = lib.listToAttrs (
    map (name: lib.nameValuePair ".pi/agent/skills/${name}" "skills/${name}") skills
    ++ map (name: lib.nameValuePair ".pi/agent/agents/${name}.md" "pi/agents/${name}.md") agents
  ) // {
    ".pi/agent/subagents.json" = "pi/config/subagents.json";
    ".pi/agent/intercom/config.json" = "pi/config/intercom.config.json";
    ".agents/pstack-models.md" = "pi/config/pstack-models.md";
  };
in
{
  options.programs.pstack = {
    enable = lib.mkEnableOption "pstack skills, Pi agents, and model/configuration links";
    rootDirectory = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/repos/mirrors/pstack";
      description = "Absolute path to the local pstack checkout. The checkout must exist before using Pi.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = lib.mapAttrs (_: source: {
      source = config.lib.file.mkOutOfStoreSymlink "${cfg.rootDirectory}/${source}";
    }) links;
  };
}
