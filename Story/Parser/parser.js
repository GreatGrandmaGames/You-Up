//I REQUIRE HEALING
const fs = require("fs");
const FILEPATH_EXPORTS = "/Users/carlosmichaelrodriguez/documents/projects/you_up/You-Up/Story/Parser/exports/";

//END CODES. Can be variable depending on what the CEOs want.
const END = -777;
const CHOOSE = -1;
const NOTRIGGERID = -9999;

//command line argument
const currentFileName = process.argv[2];
//testcase: "json/tests/test_case_2_5_18.json";

//get that hot file tho dude
const file = fs.readFileSync(currentFileName,"utf8");
const jsonFile = JSON.parse(file);

//helper functions, will put in another place later
function tabMeUpBaby(strings)
{
  let string = "";
  for (let i = 0; i < strings.length; i++)
  {
    string += strings[i] + "\t";
  }

  //returns that hot tabbed up string!!!!!
  return string;
}
function createDateString()
{
  //i was kinda bored tbh
  const d = new Date();
  return((d.getMonth()+1) + "-" + d.getDate() + "-" + d.getFullYear() + "at" + (d.getHours()%12) + "-" + d.getMinutes());
}
class Option {
  constructor(option, next)
  {
    this.option = option;
    this.next = next;
  }
};

//Parser. takes in a JSON file and outputs it to the following columns:
//["name", "messageID", "nextMessage", "message", "triggerID", "option0",
//"option0next", "option1", "option1next", "option2", "option2next"];
function parser(jsonFile)
{
  //accumulate the string
  let finalString = "";
  //for every passage
  for (let i = 0; i < jsonFile.passages.length; i++)
  {
    //get the current passage
    const currentPassage = jsonFile.passages[i];

    //instantiate all your variables
    let name, messageID, nextMessage, message, triggerID;

    //create your options arr
    const options = [];

    //get the name, add a delimiter, whatever Elliot / Nina want!!!!!! :DDDD
    name = getName(currentPassage.text);
    name = "$" + name;

    //get the pid. if it needs to be different, adjust it here. it's a string tho
    messageID = currentPassage.pid;

    //if there are no links, then it's the END.
    if (currentPassage.links === undefined)
    {
      nextMessage = END;
    }
    else
    {
      //check if there are options
      if (currentPassage.links.length > 1)
      {
        //if there is more than 1 option we gotta choose! So we set it equal to CHOOSE.
        nextMessage = CHOOSE;

        //for every option, push a  new option into our options thang
        for (let x = 0; x < currentPassage.links.length; x++)
        {
          options.push(new Option(currentPassage.links[x].name, currentPassage.links[x].pid));
        }
      }
      else
      {
        //if there's only one option, then we're chillin, and we pick the pid of the next message.
        nextMessage = currentPassage.links[0].pid;
      }
    }
    //if we don't have any tags, that means we don't have any triggers.
    //we have to figure out a convention for triggers btw
    if (currentPassage.tags === undefined)
    {
      triggerID = NOTRIGGERID;
    }
    else
    {
      //this can be upgraded if we want more than one triggerID.
      //We may need to. We should discuss this
      triggerID = currentPassage.tags[0];
    }

    //get the message
    message = getMessage(currentPassage.text);

    //build me a string!!!!!!!!
    const arr = [name, messageID, nextMessage, message, triggerID];
    for (let y = 0; y < options.length; y++)
    {
      arr.push(options[y].option);
      arr.push(options[y].next);
    }
    //tab that string up
    finalString += tabMeUpBaby(arr) + "\n";
  }
  return finalString;
}
//get the name from the string
function getName(string)
{
  //the name is between the pound key
  const s = string.split("#");
  return(s[1]);
  //getName from string (passages[i].text value) ("using # delimiters")
}

//get the message from the string
function getMessage(string)
{
  // the message is within the first and second \n's
  const s = string.split("\n");
  return s[1];
  //getMessage from strin g(passages[i].text value)
}

//fileBuilder
const line0arr = ["name", "messageID", "nextMessage", "message", "triggerID", "option0", "option0next", "option1", "option1next", "option2", "option2next"];
let fileContent = tabMeUpBaby(line0arr) + "\n";
fileContent += parser(jsonFile);
const fileName = createDateString();

//write me that tsv daddi
fs.writeFile(FILEPATH_EXPORTS + fileName + ".tsv", fileContent, "utf8", function (err) {
    if (err) {
        return console.log(err);
    }
    console.log(fileName + " was created in: " + FILEPATH_EXPORTS);
});
