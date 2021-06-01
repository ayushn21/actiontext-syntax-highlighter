# Description

`actiontext-syntax-highlighter` is an extension for `rails/actiontext` to allow the user to add language specified code blocks that are then highlighted on the server using [Rouge](http://github.com/rouge-ruby/rouge).

**Check out the demo app to see how it works!**

> Note: The experience is a bit flaky, especially on Safari. If you have any suggestions for how to improve it, please file an issue; or even better, open a Pull Request!

## How it works

This library intercepts the toolbar code button in the Trix editor and creates an attachment containing the HTML for an editable code block and language selection dropdown.

The changes to the code block are saved to the server every time edits are made. When the code block is being rendered out for viewing, it uses Rouge to highlight the content using the language selected in the dropdown; or attempting to guess the language if it's missing.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'actiontext-syntax-highlighter', require: 'action_text_syntax_highlighter/engine'
```

And then execute:

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

Finally, add a `data-highlights-code-blocks='true'` attribute to the Trix editor where you'd like to use this plugin:

```erb
<%= f.rich_text_area :content, data: { highlights_code_blocks: true } %>
```

### Bundled JavaScript

If you wish, you can import pre-bundled JavaScript instead of the module as described above:

```javascript
import "@ayushn21/actiontext-syntax-highlighter/dist"
```

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
