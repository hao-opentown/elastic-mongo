Source({name:"mongo", tail: true, namespace: "opentown./^(users|topics)$/"})
  .transform({filename: "transformers/passthrough_and_log.js", namespace: "opentown./^(users|topics)$/"})
  .save({name:"es", namespace: "opentown./^(users|topics)$/"});