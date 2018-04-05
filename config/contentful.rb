require 'mappers/help/page'

# Schema defines mapping.
# A schema can be either a string 'author' or an array ['author', AuthorMapper].
# In both cases, 'author' means it will take the 'author' from Contentful and put it into 'data/space/authors' (uses pluralize)
# in the Array case, AuthorMapper will be ran over every entry to normalize or map the data.

module ContentfulConfig
	module HelpSpace
		NAME = 'help'
		SPACE_ID = 'kw7pc879iryd'
		ACCESS_TOKEN = ENV['CONTENTFUL_MASTER_TOKEN'] # For Published Content
		PREVIEW_ACCESS_TOKEN = ENV['CONTENTFUL_PREVIEW_TOKEN'] # For All, Unpublished: Draft Content
		CDA_QUERY = { locale: '*' }
		ALL_ENTRIES = true

		SCHEMAS = [
			{ name: 'page', contentful_schema_id: 'post', mapper: ::HelpPageMapper },
			'category'
		]
	end
end
