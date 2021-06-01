<img width="861" alt="screenshot" src="https://user-images.githubusercontent.com/4924039/120343433-9f91bc80-c2f0-11eb-876b-bcb0a977a020.png">


# Description

`actiontext-syntax-highlighter` is an extension for `rails/actiontext` to allow the user to add language specified code blocks that are then highlighted on the server using [Rouge](http://github.com/rouge-ruby/rouge).

[**Check out the demo app to see how it works!**](https://actiontext-syntax-highlighter.herokuapp.com).

> Note: The experience is a bit flaky, especially on Safari. If you have any suggestions for how to improve it, please file an issue; or even better, open a Pull Request!

## How it works

This library intercepts the toolbar code button in the Trix editor and creates an attachment containing the HTML for an editable code block and language selection dropdown.

The changes to the code block are saved to the server every time edits are made. When the code block is being rendered out for viewing, it uses Rouge to highlight the content using the language selected in the dropdown; or attempting to guess the language if it's missing.


## Installation

Install ActionText if you haven't already done so:

```shell
$ bin/rails action_text:install
```

Then add this gem to your application's Gemfile:

```ruby
gem 'actiontext-syntax-highlighter', require: 'action_text_syntax_highlighter/engine'
```

And bundle and install it:

```bash
$ bundle
$ bin/rails action_text_syntax_highlighter:install
```

This will copy the database migrations into place and install the Yarn module for the frontend code.


## Usage

Add the following lines to your `application.js`:

```javascript
import { ActionTextSyntaxHighlighter } from "@ayushn21/actiontext-syntax-highlighter"
ActionTextSyntaxHighlighter.start()
```

Import the CSS for a theme from the `themes` directory:

```javascript
import "@ayushn21/actiontext-syntax-highlighter/themes/github.css"
```

The default theme is set to GitHub. If you wish to use another theme, import its CSS file and set the following config option in your `application.rb`:

```ruby
config.action_text_syntax_highlighter.default_theme = :base16
```

You can override the default theme by setting `@highlighted_code_block_theme` in your controller action where you're rendering out the rich text.

`ActionTextSyntaxHighlighter` requires a global `Trix` variable to create attachments, so require Trix in your application as below:

```javascript
window.Trix = require("trix")
```

Finally, add a `data-highlights-code-blocks='true'` attribute to the Trix editor where you'd like to use this plugin:

```erb
<%= f.rich_text_area :content, data: { highlights_code_blocks: true } %>
```

### Bundled JavaScript

If you wish, you can import pre-bundled JavaScript instead of the module as described above:

```javascript
import "@ayushn21/actiontext-syntax-highlighter/dist"
```

## Converting existing rich texts

If you've already code rich texts in your app with code blocks using a `pre` tag, you can use the method `convert_pre_tags_to_highlighted_code_blocks` on `ActionText::RichText` to migrate them over to highlighted code blocks.

For example:

```ruby
ActionText::RichText.find_each do |rich_text|
  rich_text.convert_pre_tags_to_highlighted_code_blocks
end
```

## Cleaning up deleted code blocks

`ActionTextSyntaxHighlighter` nullifies the `rich_text_id` on a `HighlightedCodeBlock` when it's removed from an `ActionText::RichText`. However it doesn't delete the record. 

I recommend you set up a cron job to execute the included `ActionTextSyntaxHighlighter::PurgeDeletedHighlightedCodeBlocksJob` which will delete all `HighlightedCodeBlock`s over a day old without an associated `RichText`.


## Contributing

1. Fork it (https://github.com/ayushn21/actiontext-syntax-highlighter/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

> If you've made a change to the frontend code, please also run `rake frontend:build` before opening your PR!

## Info

This gem was extracted from [chapter24.app](https://chapter24.app)


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
