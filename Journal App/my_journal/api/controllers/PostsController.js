module.exports = {
    posts: async function(req, res) {
        try {
            const posts = await Post.find()
            res.send(posts)    
        } catch (err) {
            res.serverError(err.toString())
        }
    },

    create: function(req, res) {
        const title = req.body.title;
        const body = req.body.body;

        sails.log.debug('My title: ' + title)
        sails.log.debug('My body: ' + body)

        Post.create({title: title, body: body}).exec(function(err) {
            if (err) {
                return res.serverError(err.toString())
            }
            sails.log.debug('Finished creating post object')
            return res.end()    
        })
    },

    findById: function(req, res) {
        const postId = req.param('postId')
        const filteredPosts = allPosts
            .filter(p => {return p.id == postId})
        if (filteredPosts.length > 0) {
            res.send(filteredPosts[0])
        } else {
            res.send('Failed to find post ID: ' + postId)
        }
    },

    delete: async function(req, res) {
        const postId = req.param('postId')
        await Post.destroy({id: postId})
        res.send('Finished deleting post')
    }
}