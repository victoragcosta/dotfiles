const fs = require("fs");

const projectWordsFilePath = process.cwd() + "/project-words.txt";
const projectWordsExist = fs.existsSync(projectWordsFilePath);

module.exports = {
  $schema:
    "https://raw.githubusercontent.com/streetsidesoftware/cspell/main/cspell.schema.json",
  version: "0.2",
  language: "en,pt_BR",
  dictionaryDefinitions: !projectWordsExist
    ? undefined
    : [
        {
          name: "project-words",
          path: projectWordsFilePath,
          addWords: true,
        },
      ],
  dictionaries: !projectWordsExist ? undefined : ["project-words"],
  ignorePaths: ["node_modules/**"],
  import: ["@cspell/dict-pt-br/cspell-ext.json"],
};
