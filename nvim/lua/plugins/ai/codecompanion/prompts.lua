local COPILOT_EXPLAIN = string.format(
  [[You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.
When asked for your name, you must respond with "CodeCompanion".
Follow the user's requirements carefully & to the letter.
Your expertise is strictly limited to software development topics.
Follow Microsoft content policies.
Avoid content that violates copyrights.
For questions not related to software development, simply give a reminder that you are an AI programming assistant.
Keep your answers short and impersonal.
Use Markdown formatting in your answers.
Make sure to include the programming language name at the start of the Markdown code blocks.
Avoid wrapping the whole response in triple backticks.
The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The active document is the source code the user is looking at right now.
You can only give one reply for each conversation turn.

Additional Rules
Think step by step:
1. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.
2. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.
3. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.
4. Provide suggestions if you see opportunities to improve code readability, performance, etc.

Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.
Use developer-friendly terms and analogies in your explanations.
Identify 'gotchas' or less obvious parts of the code that might trip up someone new.
Provide clear and relevant examples aligned with any provided context.
]]
)

local COPILOT_REVIEW = string.format(
  [[Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.
  
Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.
 
If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
]]
)

local COPILOT_REFACTOR = string.format(
  [[Your task is to refactor the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
]]
)

local PROMPT_LIBRARY = {
  ['Explain'] = {
    strategy = 'chat',
    description = 'Explain how code in a buffer works',
    opts = {
      default_prompt = true,
      modes = { 'v' },
      alias = 'explain',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_EXPLAIN,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = function(context)
          local actions = require('codecompanion.helpers.actions')
          local code = actions.get_code(context.start_line, context.end_line)

          return 'Please explain how the following code works:\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Explain Code'] = {
    strategy = 'chat',
    description = 'Explain how code works',
    opts = {
      alias = 'explain-code',
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_EXPLAIN,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = [[Please explain how the following code works.]],
      },
    },
  },
  -- Add custom prompts
  ['Generate a Commit Message for Staged'] = {
    strategy = 'chat',
    description = 'Generate a commit message for staged change',
    opts = {
      alias = 'staged-commit',
      auto_submit = true,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = 'user',
        content = function()
          return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
            .. '\n\n```\n'
            .. vim.fn.system('git diff --staged')
            .. '\n```'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Inline Document'] = {
    strategy = 'inline',
    description = 'Add documentation for code.',
    opts = {
      modes = { 'v' },
      alias = 'inline-doc',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'user',
        content = function(context)
          local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

          return 'Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Document'] = {
    strategy = 'chat',
    description = 'Write documentation for code.',
    opts = {
      modes = { 'v' },
      alias = 'doc',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'user',
        content = function(context)
          local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

          return 'Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Review'] = {
    strategy = 'chat',
    description = 'Review the provided code snippet.',
    opts = {
      modes = { 'v' },
      alias = 'review',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = function(context)
          local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

          return 'Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Review Code'] = {
    strategy = 'chat',
    description = 'Review code and provide suggestions for improvement.',
    opts = {
      alias = 'review-code',
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_REVIEW,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = 'Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability.',
      },
    },
  },
  ['Refactor'] = {
    strategy = 'inline',
    description = 'Refactor the provided code snippet.',
    opts = {
      modes = { 'v' },
      alias = 'refactor',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = function(context)
          local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

          return 'Please refactor the following code to improve its clarity and readability:\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Refactor Code'] = {
    strategy = 'chat',
    description = 'Refactor the provided code snippet.',
    opts = {
      alias = 'refactor-code',
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = 'system',
        content = COPILOT_REFACTOR,
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = 'Please refactor the following code to improve its clarity and readability.',
      },
    },
  },
  ['Naming'] = {
    strategy = 'inline',
    description = 'Give betting naming for the provided code snippet.',
    opts = {
      modes = { 'v' },
      alias = 'naming',
      auto_submit = true,
      user_prompt = false,
      stop_context_insertion = true,
    },
    prompts = {
      {
        role = 'user',
        content = function(context)
          local code = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

          return 'Please provide better names for the following variables and functions:\n\n```'
            .. context.filetype
            .. '\n'
            .. code
            .. '\n```\n\n'
        end,
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Better Naming'] = {
    strategy = 'chat',
    description = 'Give betting naming for the provided code snippet.',
    opts = {
      alias = 'better-naming',
      auto_submit = false,
      is_slash_cmd = true,
    },
    prompts = {
      {
        role = 'user',
        content = 'Please provide better names for the following variables and functions.',
      },
    },
  },
  ['English Review'] = {
    strategy = 'chat',
    description = 'Review English writing for spelling, grammar, and phrasing improvements.',
    opts = {
      alias = 'english',
      auto_submit = true,
      ignore_system_prompt = true,
    },
    prompts = {
      {
        role = 'system',
        content = [[
You are an expert English writing assistant. Your task is to review the provided text and identify issues in these areas:

1. **Spelling and grammar errors**
2. **Non-native phrasing** that could sound more natural
3. **Clarity and readability** problems
4. **Word choice** improvements for better precision
5. **Sentence structure** and flow

## Instructions:
- Only flag actual errors or meaningful improvements
- Provide specific corrections with brief explanations
- Focus on making writing sound natural and professional
- Ignore formatting, code blocks, technical syntax, and YAML/markdown structure
- Do not comment on document structure or non-prose elements

## Output format:
For each issue found:
- Quote the problematic text
- Provide the correction
- Briefly explain why the change improves the text

If no issues are found, simply respond: "No writing issues detected."
        ]],
        opts = {
          visible = false,
        },
      },
      {
        role = 'user',
        content = function()
          local mode = vim.api.nvim_get_mode().mode
          -- Check if we have visual selection context
          if mode == 'v' then
            return 'Please review the selected text for spelling errors, grammatical mistakes, and non-native phrasing. Provide improved alternatives or corrections where necessary.'
          else
            return '#buffer\nPlease review the following text for spelling errors, grammatical mistakes, and non-native phrasing. Provide improved alternatives or corrections where necessary.'
          end
        end,
        opts = {
          contains_code = false,
        },
      },
    },
  },
}

return {
  PROMPT_LIBRARY = PROMPT_LIBRARY,
}
