$(function() {
  var kosmosOpts = ['init', 'install', 'uninstall', 'list'];
  var optSelectors = _.map(kosmosOpts, function(opt) {
    return '#kosmos-' + opt;
  }).join(', ');

  var cmdRequiresExtraArgs = function(command) {
    return _.contains(['init', 'install', 'uninstall'], command);
  }

  var cliSubmitBtn = $('#cli-submit');

  var showSubmitBtn = function() {
    cliSubmitBtn.show();
  }

  var hideSubmitBtn = function() {
    cliSubmitBtn.hide();
  }

  var defaultExplanation = 'Click a button above to tell Kosmos what to do.';
  var extraArgsExplanations = {
    init: "Where is KSP on your computer? "
      + "(e.g. \"C:\\Program Files\\Steam\\KSP\" or \"/Applications/KSP_osx\")",
    install: "What mod do you want to install? (e.g. \"mechjeb\")",
    uninstall: "What mod do you want to uninstall? (e.g. \"mechjeb\")"
  }

  var cliExplanation = $('#cli-explain');

  var showExplanation = function() {
    cliExplanation.show();
  }

  var hideExplanation = function() {
    cliExplanation.hide();
  }

  var setDefaultExplanationText = function() {
    cliExplanation.text(defaultExplanation);
  }

  var cliArgsInput = $('#cli-args-input');

  var showArgsPrompt = function(command) {
    cliArgsInput.show();
    showExplanation();
    cliExplanation.text(extraArgsExplanations[command]);
  }

  var hideArgsPrompt = function() {
    cliArgsInput.hide();
  }

  var handleSelectCommand = function(command) {
    // First, change the pseudo-CLI to show that command and hide the waiting-
    // for-user-input stuff.
    $('#command').text(command);
    $('#awaiting-user-input').hide();

    // Then, allow the user to give more args or submit his command.
    if (cmdRequiresExtraArgs(command)) {
      showArgsPrompt(command);
    } else {
      hideArgsPrompt();
      hideExplanation();
    }

    showSubmitBtn();
  }

  $(optSelectors).click(function(event) {
    handleSelectCommand(event.target.innerText);
  });

  hideSubmitBtn();
  hideArgsPrompt();
});
