module.exports = {
  friendlyName: 'Delete',
  description: 'Delete post.',
  inputs: {
    postId: {
      type: 'string',
      required: true
    }
  },
  exits: {
    invalid: {
      description: 'This was an invalid post to delete'
    }
  },
  fn: async function (inputs) {
    // All done.
    console.log('We are in delete post action.')
    console.log('Trying to delete post with ID: ' + inputs)
    // throw('invalid')
    const record = await Post.destroy({id: inputs.postId}).fetch()
    if (record.length == 0) {
      throw({invalid: {error: 'Record does not exist'}})
    }
    return record;
  }
};
