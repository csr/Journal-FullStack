module.exports = {
  friendlyName: 'Crenodemanate',
  description: 'Create post.',
  inputs: {
    title: {
      description: 'Title of the post object',
      type: 'string',
      required: true
    },
    body: {
      type: 'string',
      required: true
    }
  },
  exits: {
  },
  fn: async function (inputs) {
    console.log('We are now inside the post/create action')
    await Post.create({title: inputs.title, body: inputs.body})
    return;

  }
};
