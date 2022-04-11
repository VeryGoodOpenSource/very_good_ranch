# Gameplay

## Entities

### Unicorn

A unicorn is an mystical animal that roams your ranch, it can be either a baby, kid, teenager or an adult. These are the stages of a unicorn. 

Each unicorn has a happiness counter, this can be influenced by a few game aspects:
- Feeding the preferred food.
- Petting them.
- Playing with them.

A unicorn goes to the next stage when they have eaten the right amount of food and are on the happiness threshold for their current stage.

These thresholds will be determined when the development of the game has processed a bit further.

### Food

Food is what a player uses to feed their unicorns. Each stage of unicorn has a preferred type of food, feeding them the correct food will ensure they grow up. Feeding the incorrect food will make them mad.

Food appears in the game overtime, unicorns are magical so their food is as well. The player can click on the food to store it so that they can feed it to a unicorn later.

## Game values

The game starts with an empty ranch, a single baby unicorn has just appeared in the players ranch and it is now their sole responsibility to keep the unicorn happy. The player is now a unicorn parent.
- **VALUE**: This adds RESPONSIBILITY, giving the player a purpose.

Feeding unicorns will ensure they "grow" through their stages. 
- **VALUE**: This adds PROGRESSION, keeping the player feel that they still are having an impact.

The better the player takes care of the unicorns the happier they are and they will tell their lovely friends that the player is a nice person. Therefore more unicorns will show themselves overtime.
- **VALUE**: This adds SATISFACTION, strengthens the purpose and progression feeling of a player.

If the player forgets to feed the unicorns, because they didn't open the app to feed the unicorns, or make them mad they will leave the player's ranch. If the last unicorn leaves it is game over and the player can start a new game.
- **VALUE**: This adds GUILT, makes players come back to the game to ensure their progression.

## Measure scoring

Scoring is based on the total happiness of all the unicorns in the ranch multiplied by a multiplier from the stage they are in.

## Controls

### Feeding

Feeding a unicorn their preferred food will add to their grow value, once they have reached the threshold of their current stage they will evolve into the next stage. Feeding a unicorn is done by dragging food to the unicorn.

### Petting

A player can pet a unicorn to make it feel appreciated, this will increase it's happiness and therefore it will stay on the ranch. Each unicorn can be petted separately and it will reset after an X amount of time after the last pet on that unicorn.

# Required assets 

## Ranch

The ranch itself should be visualized to make the game more visually attractive. An idea for this could be to have a the whole screen be the ranch "field" and have a fence around it as a border. The top part could then be bigger with a farm on it and maybe some other ranch-based objects.

The sprites for this would be:

- A grass sprite for the field itself
- A [Nine Slice](https://en.wikipedia.org/wiki/9-slice_scaling) sprite of the fence, to border of the field
- A few ranch-based objects like a farm house or a windmill that we could place on top of the game to make it more of a ranch.

Audio:

- Some simple catchy background music, loop-able.

## Unicorn

For the unicorn entity we need the following assets (each of these should be done for the 4 stages we have):

For sprites:

- An idle sprite/animation, where the unicorn is standing still.
- A sprite animation for a roaming unicorn.
- Animation for when the player plays with the unicorn.
- Animation of the unicorn being happy, we could use this after it gets food or when the player pets the unicorn.

For audio:

- Whenever the unicorn gets food there should be an audio playing.
- When the unicorn goes to the next stage there should be an audio effect.

## Food

For the food entity we need a few types of sprites for each type of food.

The type of foods are:

- 🧁 Cupcakes
- 🍭 Lollipops
- 🥞 Pancakes
- 🍦 Ice creams
- 🍬 Candies

Depending on how food will be used for the different stages of the unicorn we might need multiple different sprite for each type of food.
