# CL-greed
[Poor] implementation of the Greed game as assigned at the end of Lisp Koans

## Wat.
This is my first fill-on Common Lisp program: the fruit of completing Google's [Lisp Koans](https://github.com/google/lisp-koans) (which I would have also included if Emacs hadn't mysteriously deleted the direactory as soon as I finished. Truly the most humbling lesson in Zen is the unexpected loss of an attachment). It's **terrible**. But that's okay; this project was only undertaken to evaluate the virtues of Lisp. Conclusion: while Lisp is an excellent language, it's not quite as friendly as a rigorously-SRFI'd Scheme. 

The separate namespaces alone make even the most mundane tasks needlessly complex. Additionally. the koans didn't leave me with a confident understanding of the CLOS. What little was to be had was not mind-blowing. Some of the syntax involved is pretty unwieldy. However, SLIME is **much** better than Geiser in Emacs. There are also a couple of nice features in Lisp that Scheme desperately needs. Nil, for example, is wonderful: e.g. having (car '()) -> nil rather than an error and (eq '() nil) -> t. Not sure what Messrs. Sussman and Steele were thinking when they broke with this convention. Nonetheless. an early loss in interest in this program shows in the widedpread use of mutable state and other careless design. 

Anyway, the game is fully playable and supports as many players as you like. Since the rules didn't specify and because I really don't care that much, the winner in the event of a tie is whoever happens to have the highest score and be last in the list of players. 

## Usage
1. Clone this repo.
2. Load greed.lsp into your Lisp REPL of choice
3. Lower your expectations
4. (play-greed)
