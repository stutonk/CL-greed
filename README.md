# CL-greed
[Poor] implementation of the Greed game as assigned at the end of Lisp Koans

## Wat.
This is my first fill-on Common Lisp program: the fruit of completing Google's [Lisp Koans](https://github.com/google/lisp-koans) (which I would have also included if Emacs hadn't mysteriously deleted the direactory as soon as I finished. Truly the most humbling lesson in Zen is the unexpected loss of an attachment). It's **terrible**. Finishing the koans and making this program has expanded my awarness and I have had the following realization: while Lisp is a fine language, it's no substitute for Scheme. The separate namespaces alone make even the most mundane tasks needlessly complex. I lost interest early on and it shows in the widedpread use of mutable state and other careless design. Anyway, the game is fully playable and supports as many players as you like. Since the rules didn't specify and because I really don't care that much, the winner in the event of a tie is whoever happens to have the highest score and be last in the list of players. 

## Usage
1. Clone this repo.
2. Load greed.lsp into your Lisp REPL of choice
3. Lower your expectations
4. (play-greed)
