# 3 Coloring Problem

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Mathinfoly](http://www.mathinfoly.org/assets/img/logo/logomathinfoly2.png)</br></br>
Solution about 3 Coloring Problem by using SAT Solver Glucose.</br>
**Group Member**: Kelun CHAI, [Claire ZENG](claire.s.zeng@gmail.com), [Dimitri Lesnoff](dimitri.lesnoff@gmail.com),[Igor Martayan](igor@martayan.org),[Matthieu LACOTE](mat.lac702@gmail.com) and **Tutor** [Pascal LAFOURCADE](Pascal.LAFOURCADE@uca.fr).</br>
This repository contains:
1. **Python scripts** (.py files) to transform the graph.
2. **OCaml scripts** to create cnf clauses.
3. **Slides** of presentation (in French).

## Table of Contents
- [Background](#background)
- [Introduction](#introduction)
- [Install](#install)

## Background
Course at Summer School on Cryptography, Blockchain and Program Verification [Mathinfoly 2019](http://www.mathinfoly.org/)
at INSA Lyon on 27-31 August 2019. </br></br>
We trying to use Glucose SAT Solver to resolve 3 Coloring Problem.

## Introduction
Take a graph G, with n vertices, V = {x1, x2, … , xn}, we can color the vertices of a graph in such a way so that no two adjacent vertices have the same color. </br>
Graph coloring has many practical and theoretical applications such as:
- Air traffic control and flight scheduling
- Sudoku Puzzles</br>
In the Three Color Problem, we want to see if we can color the graph so that only 3 colors are used. If graph G can be colored this way, G is called 3-colorable.

## Install
![Glucose](https://www.labri.fr/perso/lsimon/img/glue-stick-120px.jpg)
This project uses [Glucose](https://www.labri.fr/perso/lsimon/glucose/). Go check them out if you don't have them locally installed. 
