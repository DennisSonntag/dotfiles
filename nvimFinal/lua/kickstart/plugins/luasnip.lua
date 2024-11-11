return {
  'L3MON4D3/LuaSnip',
  enabled = false,
  event = 'InsertEnter',
  config = function()
    local ls = require 'luasnip'

    local types = require 'luasnip.util.types'
    ls.config.set_config {
      history = false,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { ' « ', 'NonTest' } },
          },
        },
      },
    }

    local s, i, t, f, c = ls.s, ls.i, ls.t, ls.function_node, ls.choice_node
    local fmt = require('luasnip.extras.fmt').fmt
    local fmta = require('luasnip.extras.fmt').fmta
    local rep = require('luasnip.extras').rep

    for _, lang in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'svelte' } do
      ls.add_snippets(lang, {
        s(
          'log',
          fmt('console.log({});', {
            i(1),
          })
        ),

        s(
          'af',
          fmt(
            [[
					const {} = ({}) => {{
						{}
					}};
					]],
            {
              i(1, 'name'),
              i(2, 'param'),
              i(3),
            }
          )
        ),

        s(
          'for',
          fmta(
            [[
					for <cond> {
						<code>
					}
					]],
            {
              cond = c(1, {
                fmt('(let {} = 0; {} < {}; {}++)', {
                  i(1, 'i'),
                  rep(1),
                  i(2, 'length'),
                  rep(1),
                }),
                fmt('(const {} of {})', {
                  i(1, 'i'),
                  i(2, 'iterator'),
                }),
                fmt('(const {} in {})', {
                  i(1, 'i'),
                  i(2, 'iterator'),
                }),
              }),
              code = i(2),
            }
          )
        ),

        s(
          'foreach',
          fmt(
            [[
					{}.foreach({} => {{
						{}
					}});
				]],
            {
              i(1, 'array'),
              i(2, 'elm'),
              i(3),
            }
          )
        ),

        s(
          'map',
          fmt(
            [[
					{}.map({} => {{
						{}
					}});
				]],
            { i(1, 'array'), i(2, 'elm'), i(3) }
          )
        ),
        s(
          'filter',
          fmt(
            [[
					{}.filter({} => {{
						{}
					}});
				]],
            { i(1, 'array'), i(2, 'elm'), i(3) }
          )
        ),
        s(
          'if',
          fmt(
            [[
					if ({}) {{
						{}
					}}{}
				]],
            { i(1, 'condition'), i(2), i(3) }
          )
        ),
        s(
          'elif',
          fmt(
            [[
					else if ({}) {{
						{}
					}}{}
				]],
            { i(1, 'condition'), i(2), i(3) }
          )
        ),
        s(
          'else',
          fmt(
            [[
					else {{
						{}
					}}
				]],
            { i(1) }
          )
        ),
        s(
          'while',
          fmt(
            [[
					while ({}) {{
						{}
					}}
				]],
            { i(1, 'condition'), i(2) }
          )
        ),
        s(
          'dowhile',
          fmt(
            [[
					do {{
						{}
					}} while ({});
				]],
            { i(1), i(2, 'condition') }
          )
        ),

        s(
          'trycatch',
          fmt(
            [[
					try {{
						{}
					}} catch ({}) {{
						{}
					}}
				]],
            { i(1), i(2, 'err'), i(3) }
          )
        ),
        s(
          'settimeout',
          fmt(
            [[
					setTimeout(() => {{
						{}
					}}, {});"
				]],
            { i(1), i(2, 'timeout') }
          )
        ),
        s(
          'setinterval',
          fmt(
            [[
					setInterval(() => {{
						{}
					}}, {});"
				]],
            { i(1), i(2, 'timeout') }
          )
        ),
        s(
          'func',
          fmta(
            [[
					function <name>(<param>) {
						<code>
					}]],
            { name = i(1), param = i(2), code = i(3) }
          )
        ),
        s(
          'imp',
          fmt(
            [[
					import {} from "{}";
				]],
            { i(1, 'item'), i(2, 'lib') }
          )
        ),
        s(
          'case',
          fmt(
            [[
					case {}:
						{}
						break;
				]],
            { i(1), i(2) }
          )
        ),
        s(
          'switch',
          fmt(
            [[
					switch ({}) {{
						case {}:
						{}
						break;
						default:
						{}
						break;
					}}
				]],
            { i(1), i(2), i(3), i(4) }
          )
        ),
      })
    end
    ls.add_snippets('typescriptreact', {
      s(
        'comp',
        fmt(
          [[
				import type {{ FC }} from "react";

				type PropTypes = {{
					{}: {};
				}};

				const {}: FC<PropTypes> = ({{ {} }}) => {{
					return (
						{}
					);
				}};

				export default {};
			]],
          {
            i(1, 'prop'),
            i(2, 'type'),
            i(3, 'Component'),
            rep(1),
            i(4),
            rep(3),
          }
        )
      ),
    })

    local sameCap = function(index)
      return f(function(arg)
        local input = arg[1][1]
        return input:sub(1, 1):upper() .. input:sub(2)
      end, { index })
    end

    for _, lang in ipairs { 'typescriptreact', 'javascriptreact' } do
      ls.add_snippets(lang, {
        s(
          'us',
          fmt('const [{}, set{}] = useState({});', {
            i(1, 'var'),
            sameCap(1), -- Pass an empty string to the returned function
            i(2),
          })
        ),
        s(
          'class',
          fmt([[className="{}"]], {
            i(1),
          })
        ),
        s(
          'ref',
          fmt('const {} = useRef({});', {
            i(1, 'refName'),
            i(2, 'null'),
          })
        ),
        s(
          'ue',
          fmt(
            [[
					useEffect(()=> {{
						{}
					}},[{}])
					]],
            { i(1), i(2) }
          )
        ),
      })
    end

    for _, lang in ipairs { 'typescriptreact', 'javascriptreact', 'html', 'astro' } do
      ls.add_snippets(lang, {
        s('script', fmt('<script>{}</script>', { i(1) })),
        s('script:src', fmt([[<script defer src="{}"></script>]], { i(1) })),
      })
    end

    ls.add_snippets('svelte', {
      s(
        'script',
        fmt(
          [[
				<script lang="ts">
					{}
				</script>]],
          { i(1) }
        )
      ),
      s(
        'if',
        fmta(
          [[
				{#if <condition>}
					<html>
				{/if}
				]],
          { condition = i(1), html = i(2) }
        )
      ),
      s(
        'if',
        fmta(
          [[
				{#if <condition>}
					<html>
				{/if}
				]],
          { condition = i(1), html = i(2) }
        )
      ),
      s('else', t '{:else}'),
      s('else', fmta('{:else if <condition>}', { condition = i(1) })),
      s('slot', fmt('<slot>{}</slot>', { i(1) })),
      s(
        'each',
        fmta(
          [[
				{#each <list> as <val>}
					<html>
				{/each}
				]],
          {
            list = i(1),
            val = i(2),
            html = i(3),
          }
        )
      ),
      s(
        'await',
        fmta(
          [[
					{#await <val>}
						<html>
					{/await}
					]],
          {
            val = i(1),
            html = i(2),
          }
        )
      ),
      s(
        'onmount',
        fmta(
          [[
				onMount(() =>> {
					<code>
				})
				]],
          { code = i(1) }
        )
      ),
      s('then', fmta('{:then <val>}', { val = i(1) })),
      s('catch', fmta('{:catch <val>}', { val = i(1) })),
    })

    ls.add_snippets('rust', {
      s('print', fmt('{}("{}");', { c(1, { t 'println!', t 'print!' }), i(2) })),
      s('format', fmt('format!("{}");', { i(1) })),
      s(
        'if',
        fmta(
          [[
				if <condition> {
					<code>
				}
				]],
          {
            condition = i(1),
            code = i(2),
          }
        )
      ),
      s(
        'if-let',
        fmta(
          [[
				if let <name> = <expr> {
					<code>
				}
				]],
          {
            name = i(1),
            expr = i(2),
            code = i(3),
          }
        )
      ),
      s(
        'for',
        fmta(
          [[
				for <val> in <list> {
					<code>
				}
				]],
          {
            val = i(1),
            list = i(2),
            code = i(3),
          }
        )
      ),
      s(
        'struct',
        fmta(
          [[
				struct <name> {
					<vals>
				}
				]],
          {
            name = i(1),
            vals = i(2),
          }
        )
      ),
      s(
        'enum',
        fmta(
          [[
				enum <name> {
					<vals>
				}
				]],
          {
            name = i(1),
            vals = i(2),
          }
        )
      ),
    })

    ls.add_snippets('lua', {
      s(
        'func',
        fmta(
          [[
				function<name>(<param>)
					<code>
				end
				]],
          {
            name = i(1),
            param = i(2),
            code = i(3),
          }
        )
      ),
      s(
        'if',
        fmta(
          [[
				if <condition> then
					<code>
				end
				]],
          {
            condition = i(1),
            code = c(2, { i(2), fmt('{}\nelse\n {}', { i(1), i(2) }) }),
          }
        )
      ),
    })

    for _, lang in ipairs { 'typescriptreact', 'javascriptreact', 'html', 'astro', 'svelte' } do
      ls.add_snippets(lang, {
        s('doctype', t '<!DOCTYPE>'),
        s('a', fmt([[<a href="{}">{}</a>]], { i(1), i(2) })),
        s('abbr', fmt([[<abbr title="{}">{}</abbr>]], { i(1), i(2) })),
        s('address', fmt('<address>{}</address>', { i(1) })),
        s('area', fmt([[<area shape="{}" coords="{}" href="{}" alt="{}">]], { i(1), i(2), i(3), i(4) })),
        s('article', fmt('<article>{}</article>', { i(1) })),
        s('aside', fmt('<aside>{}</aside>', { i(1) })),
        s('audio', fmt('<audio controls>{}</audio>', { i(1) })),
        s('b', fmt('<b>{}</b>', { i(1) })),
        s('base', fmt([[<base href="{}" target="{}">]], { i(1), i(2) })),
        s('bdi', fmt('<bdi>{}</bdi>', { i(1) })),
        s('bdo', fmt([[<bdo dir="{}">{}</bdo>]], { i(1), i(2) })),
        s('big', fmt('<big>{}</big>', { i(1) })),
        s('blockquote', fmt([[blockquote cite="{}">{}</blockquote>]], { i(1), i(2) })),
        s('body', fmt('<body>{}</body>', { i(1) })),
        s('br', t '<br>'),
        s('button', fmt([[<button type="{}">{}</button>]], { i(1), i(2) })),
        s('canvas', fmt([[<canvas id="{}">{}</canvas>]], { i(1), i(2) })),
        s('caption', fmt('<caption>{}</caption>', { i(1) })),
        s('cite', fmt('<cite>{}</cite>', { i(1) })),
        s('code', fmt('<code>{}</code>', { i(1) })),
        s('col', t '<col>'),
        s('colgroup', fmt('<colgroup>{}</colgroup>', { i(1) })),
        s('command', fmt('<command>{}</command>', { i(1) })),
        s('datalist', fmt('<datalist>{}</datalist>', { i(1) })),
        s('dd', fmt('<dd>{}</dd>', { i(1) })),
        s('del', fmt('<del>{}</del>', { i(1) })),
        s('details', fmt('<details>{}</details>', { i(1) })),
        s('dialog', fmt('<dialog>{}</dialog>', { i(1) })),
        s('dfn', fmt('<dfn>{}</dfn>', { i(1) })),
        s('div', fmt('<div>{}</div>', { i(1) })),
        s('dl', fmt('<dl>{}</dl>', { i(1) })),
        s('dt', fmt('<dt>{}</dt>', { i(1) })),
        s('em', fmt('<em>{}</em>', { i(1) })),
        s('embed', fmt([[<embed src="{}">]], { i(1) })),
        s('fieldset', fmt('<fieldset>{}</fieldset>', { i(1) })),
        s('figcaption', fmt('<figcaption>{}</figcaption>', { i(1) })),
        s('figure', fmt('<figure>{}</figure>', { i(1) })),
        s('footer', fmt('<footer>{}</footer>', { i(1) })),
        s('form', fmt('<form>{}</form>', { i(1) })),
        s('hn', fmt('<h{}>{}</h{}>', { c(1, { t '1', t '2', t '3', t '4', t '5', t '6' }), i(2), rep(1) })),
        s('head', fmt('<head>{}</head>', { i(1) })),
        s('header', fmt('<header>{}</header>', { i(1) })),
        s('hgroup', fmt('<hgroup>{}</hgroup>', { i(1) })),
        s('hr', t '<hr>'),
        s('html', fmt('<html>{}</html>', { i(1) })),
        s(
          '!',
          fmt(
            [[
						<!DOCTYPE html>
						<html lang="us-en">
							<head>
								<title>{}</title>
								<meta charset="UTF-8">
								<meta name="viewport" content="width=device-width, initial-scale=1">
							</head>
							<body>
								{}
							</body>
						</html>
					]],
            { i(1), i(2) }
          )
        ),
        s('i', fmt('<i>{}</i>', { i(1) })),
        s('iframe', fmt([[<iframe src="{}">{}</iframe>]], { i(1), i(2) })),
        s('img', fmt([[<img src="{}" alt="{}">]], { i(1), i(2) })),
        s('input', fmt([[<input type="{}" name="{}" value="{}">]], { i(1), i(2), i(3) })),
        s('ins', fmt('<ins>{}</ins>', { i(1) })),
        s('keygen', fmt([[<keygen name="{}">]], { i(1) })),
        s('kbd', fmt('<kbd>{}</kbd>', { i(1) })),
        s('label', fmt([[<label for="{}">{}</label>]], { i(1), i(2) })),
        s('legend', fmt('<legend>{}</legend>', { i(1) })),
        s('li', fmt('<li>{}</li>', { i(1) })),
        s('link', fmt([[link rel="{}" type="{}" href="{}">]], { i(1), i(2), i(3) })),
        s('link:css', fmt([[<link rel="stylesheet" type="text/css" href="{}.css">]], { i(1) })),
        s('main', fmt('<main>{}</main>', { i(1) })),
        s('map', fmt([[<map name="{}">{}</map>]], { i(1), i(2) })),
        s('mark', fmt('<mark>{}</mark>', { i(1) })),
        s('menu', fmt('<menu>{}</menu>', { i(1) })),
        s('menuitem', fmt('<menuitem>{}</menuitem>', { i(1) })),
        s('meta', fmt([[<meta name="{}" content="{}">]], { i(1), i(2) })),
        s('meter', fmt([[<meter value="{}">{}</meter>]], { i(1), i(2) })),
        s('nav', fmt('<nav>{}</nav>', { i(1) })),
        s('noscript', fmt('<noscript>{}</noscript>', { i(1) })),
        s('object', fmt([[<object width="{}" height="{}" data="{}">{}</object>]], { i(1), i(2), i(3), i(4) })),
        s('ol', fmt('<ol>{}</ol>', { i(1) })),
        s('optgroup', fmt('<optgroup>{}</optgroup>', { i(1) })),
        s('option', fmt([[<option value="{}">{}</option>]], { i(1), i(2) })),
        s('output', fmt([[<output name="{}" for="{}">{}</output>]], { i(1), i(2), i(3) })),
        s('p', fmt('<p>{}</p>', { i(1) })),
        s('param', fmt([[<param name="{}" value="{}">]], { i(1), i(2) })),
        s('pre', fmt('<pre>{}</pre>', { i(1) })),
        s('progress', fmt([[<progress value="{}" max="{}">{}</progress>]], { i(1), i(2), i(3) })),
        s('q', fmt('<q>{}</q>', { i(1) })),
        s('rp', fmt('<rp>{}</rp>', { i(1) })),
        s('rt', fmt('<rt>{}</rt>', { i(1) })),
        s('ruby', fmt('<ruby>{}</ruby>', { i(1) })),
        s('s', fmt('<s>{}</s>', { i(1) })),
        s('samp', fmt('<samp>{}</samp>', { i(1) })),
        s('section', fmt('<section>{}</section>', { i(1) })),
        s('select', fmt('<select>{}</select>', { i(1) })),
        s('small', fmt('<small>{}</small>', { i(1) })),
        s('source', fmt([[<source src="{}" type="{}">]], { i(1), i(2) })),
        s('span', fmt('<span>{}</span>', { i(1) })),
        s('strong', fmt('<strong>{}</strong>', { i(1) })),
        s('style', fmt('<style>{}</style>', { i(1) })),
        s('sub', fmt('<sub>{}</sub>', { i(1) })),
        s('sup', fmt('<sup>{}</sup>', { i(1) })),
        s('summary', fmt('<summary>{}</summary>', { i(1) })),
        s('table', fmt('<table>{}</table>', { i(1) })),
        s('tbody', fmt('<tbody>{}</tbody>', { i(1) })),
        s('td', fmt('<td>{}</td>', { i(1) })),
        s('textarea', fmt([[<textarea rows="{}" cols="{}">{}</textarea>]], { i(1), i(2), i(3) })),
        s('tfoot', fmt('<tfoot>{}</tfoot>', { i(1) })),
        s('thead', fmt('<thead>{}</thead>', { i(1) })),
        s('th', fmt('<th>{}</th>', { i(1) })),
        s('time', fmt([[<time datetime="{}">{}</time>]], { i(1), i(2) })),
        s('title', fmt('<title>{}</title>', { i(1) })),
        s('tr', fmt('<tr>{}</tr>', { i(1) })),
        s('track', fmt([[<track src="{}" kind="{}" srclang="{}" label="{}">]], { i(1), i(2), i(3), i(4) })),
        s('u', fmt('<u>{}</u>', { i(1) })),
        s('ul', fmt('<ul>{}</ul>', { i(1) })),
        s('var', fmt('<var>{}</var>', { i(1) })),
        s('video', fmt([[<video width="{}" height="{}" controls>{}</video>]], { i(1), i(2), i(3) })),
      })
    end
  end,
}
