/**
 * Typst template for Noting
 * Author: Cheng XIN
 * Mail: claudexin@outlook.com
 */

/**
 * Some useful commands
 */
#let thbox(name: none, color: gray, cate: "Theorem", refs: none, body) = block(
    width: 100%,
    fill: color,
    inset: 5pt)[

    #align(left, text[
        #text(weight: "bold")[#cate #text(rgb("#D0104C"))[#refs]:] #name
        #label(refs)
    ])
    #body
]


#let theorem(name: none, refs: none, body) = thbox(
    name: name,
    color: luma(230),
    cate: "Theorem",
    refs: refs,
    body
)

#let definition(name: none, refs: none, body) = thbox(
    name: name,
    color: rgb("#91B493"),
    cate: "Definition",
    refs: refs,
    body
)

#let ref(l) = link(l, text(rgb("#D0104C"))[*#l*])

#let card(name, body) = block(fill: rgb("#EEA9A9"), inset: 10pt, width: 100%, stroke: black)[
    #set enum(numbering: x => text(rgb("#1B813E"))[#sym.square.filled #x])

    #align(left, text(14pt)[*#name*])
    #body
]

/**
 * Heading, `show` rules
 */
#let report(info, body) = {

    set heading(numbering: "I.A")
    set text(10pt, font: ("Proxima Nova"), fallback: true)
    set par(justify: true)
    set page(
        paper: "us-letter",
        margin: (top: 1cm, bottom: 1cm),
        numbering: "1/1"
    )

    block(width: 100%,
        fill: rgb("#DC9FB4"),
        clip: true,
        stroke: black,
        radius: (
            top-left: 5pt,
            top-right: 5pt,
            bottom-left: 5pt,
            bottom-right: 5pt
        ),
        inset: 10pt)[

        #align(center, text(14pt, font: "Latin Modern Roman")[*#info.title*])
        #align(left, text(10pt, font: "Latin Modern Roman")[
            *Author:* #info.author \
            *Date:* #info.date \
            *Keywords:* #info.keywords.join("; ")
        ])
    ]

    /**
     * Outline
     */
    outline()
    line(length: 100%)
    v(1.5cm)

    /**
    * Programming Language Syntax Highlight
    */
    show raw.where(lang: "promela"): it => {
        let keywords = (
            "proctype", "chan", "of", "do", "od",
            "typedef", "byte", "int", "inline",
            "active"
        ).join("|")

        let functions = (
            "printf",
        ).join("|")

        let wrap_str(ks) = "\b(" + ks + ")\b"

        show regex(wrap_str(keywords)): set text(blue)
        show regex(wrap_str(functions)): set text(blue)
        show regex("\"(.*?)\""): set text(green)

        it.text
    }

    /**
     * Emph and strong
     */
    show emph: it => {
        text(rgb("#6699A1"), style: "normal", it.body)
    }

    show strong: it => {
        text(rgb("#8E354A"), weight: "bold", it.body)
    }

    /**
     * Heading level 1 and level 2
     */
    show heading.where(level: 1): it => align(center, smallcaps(it))
    show heading.where(level: 2): it => text(weight: "bold", it)

    /**
     * Main body
     */
    body
}
