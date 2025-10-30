#import "@preview/touying:0.6.1": *
#import themes.simple: *

#show: simple-theme.with(
  aspect-ratio: "16-9",
  primary: black,
  header-right: "Потоки",
  header: none,
  footer: "Теория графов",
)

#set text(size: 20pt)

#show raw.where(block: true): code => {
  show raw.line: line => {
    context {
      let t = text(fill: gray, size: 14pt)[#line.number]
      t
      h(2em - measure(t).width)
    }
    line.body
  }
  code
}

#show raw: set text(
  font: "JetBrainsMono NF",
  ligatures: false,
  size: 14pt,
  features: (calt: 0),
)

#title-slide[
  = Сети. Потоки в сетях
  #v(2em)
  
  Толстов Роберт Сергеевич,\
  Рудяк Артём Станиславович.
]

== Зачем ещё что что-то учить к экзамену?

#pause

#grid(columns: (2fr, 1fr), column-gutter: 1em)[
  #figure(
    image("../images/village.png", height: 80%),
  )
][
  #pause
  #figure(
    image("../images/baby-crying.png", height: 80%),
  )
]

---

#grid(columns: (2fr, 1fr), column-gutter: 1em)[
  #figure(
    image("../images/village.png", height: 80%),
  )
][
  #figure(
    image("../images/baby-watered.png", height: 80%),
  )
]

---

Для ситуаций, когда *важна пропускная способность рёбер* была описана теория потоковых сетей.

#pause

Данная лекция -- лишь мелководье, однако мы успеем:

#pause
- познакомиться с теоретическими основами;
#pause
- рассмотреть ключевые практические задачи теории потоков;
#pause
- изучить алгоритмы для их решения.

== Теоретические основы

/ Сеть $G = angle.l V, E angle.r$: --- это ориентированный граф, такой что:

$ forall (u, v) in E quad c(u,v) > 0; $
$ forall (u, v) in.not E quad c(u,v) = 0. $

Функцию $c(u, v)$ называют *пропускной способностью* ребра $(u, v)$.

#pause

В сетях выделяют две вершины: исток $s$ и сток $t$.

---

/ Поток $f$ в сети $G$: --- это функция $f : V times V -> RR_(gt.eq.slant 0)$#pause, такая что $forall u, v in V$:

1. $f(u, v) = -f(v, u)$ (антисимметричность);
#pause
2. $f(u, v) <= c(u, v)$;

#pause

/ Величина потока: --- это объём потока, выходящий из истока. $|f| = limits(sum)_(u in V) f(s, v)$.

---

/ Закон сохранения потока.: Для сети $G = angle.l V, E angle.r$ с потоком $f$ верно, что:

$ forall v in V \\ {s, t} quad limits(sum_(u in V\ (u, v) in E)) f(u, v) = limits(sum_(w in V\ (v, w) in E)) f(v, w). $

#pause

Проще говоря, сумма входящих потоков равна сумме выходящих. Очевидно, что выполняется для всех вершин кроме истока и стока.

---

#figure(
  image("../images/flow-example.png", width: 85%),
)

= Интерактив на крутой суперприз

== Вопросы

+ *Что такое источник?* #pause Вершина, из которой исходит поток
#pause

+ *Что такое сток?* #pause Вершина, в которую поток должен поступить
#pause

+ *Что такое пропускная способность?* #pause Максимальный объём потока, разрешённый на дуге
#pause

+ *Что такое поток?* #pause Реальное значение ресурса, которое протекает по дуге. 

== Задача максимального потока

/ Задача.: Пусть дана сеть $G = angle.l V, E angle.r$. Требуется найти функцию потока:

$ f_max = limits(max)_f |f|, $

которая, очевидно, удовлетворяет всем свойствам функции потока. Такую функцию и называют функцией максимального потока.

#pause

Далее рассмотрим различные алгоритмы для решения этой задачи.
