# Flexbox

__Lesson Duration: 30 minutes__

### Learning Objectives

- Understand the purpose of Flexbox
- Be able to use Flexbox to control the layout of elements within a container

## Introduction

CSS is used to control the aesthetics of a website. We've seen that CSS can be used to change the appearance of text and other elements on a page. CSS can also be used to control the layout of a page, deciding how elements should be positioned in relation to one another. In this lesson we will learn how to use Flexbox to organise child elements into rows or columns within a parent container element. This could be useful for positioning navigation links within a header, for example, or images within an image gallery.

Open the start code with your text editor and take a moment to think about the structure of the HTML and the styling that is being applied to the elements. Then open index.html with your web browser. Let's imagine that each of the boxes represents an image in an image gallery.

## Properties

Flexbox provides us with two sets of properties that can be used to control the layout of our elements. One that should be applied to the parent element and one that should be applied to the child elements within.
[CSS Tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) offer a fantastic Flexbox resource, describing and illustrating exactly what effects each of these properties can have on the layout of our elements.

In the context of our example, the parent element will be the `section` with the id `gallery`. The `div` elements with the class `image` will be the child elements, which we want to control the layout of.

In order to start using flexbox, the first thing that we have to do is set the `display` property of our parent element to `flex`.

```css
/* style.css */

#gallery {
  display: flex; /* NEW */
}
```

If we refresh our web page in the browser, we should see that things have changed. By default, Flexbox will try to squish all of our child elements on to a single row. This usually won't be what we want, but that's okay. We just need to spend a bit of time tweaking some of the properties that are available to us.

We can use the `flex-flow` property to tell Flexbox that we would prefer to have elements wrap onto a new line, rather that resize to fit on a single line. If we wanted to use columns, rather than rows, we could also specify that here.

```css
#gallery {
  display: flex;
  flex-flow: row wrap; /* NEW */
}
```

The real value of Flexbox can be seen in its responsiveness. Try resizing the page and see what happens to our elements. We don't get a horizontal scroll bar when our elements don't fit on the page, instead Flexbox moves them around in response to the size of our window. Better yet, we have control over how Flexbox manipulates our elements in response to the size of the window.

Say we always wanted 3 elements to be displayed per row. These three elements should occupy roughly 1/3 of the window, regardless of its size. We can do this using the `flex` property of our child elements, and specifying how much of the space in each row we would like each element to occupy.

```css
.image {
  width: 250px;
  height: 250px;
  background-color: lightblue;
  border: 1px solid white;
  flex: 33%; /* NEW */
}
```

> Note: We're using 33%, rather than 33.333333%, as the 1px border on each side of each element is not taken into account when calculating width. If we were to use 33.333333% then we would only be able to fit 2 elements plus their borders on a line.

> (1px + 33.333333% + 1px) + (1px + 33.333333% + 1px) + (1px + 33.333333% + 1px) is more than 100%!

If we refresh the page again, our page should be starting to take shape nicely. If we were to switch the boxes out for some images, we would have a fancy little image gallery here.

### Task (20 minutes): More Complex Layouts

Reference: [CSS Tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

Sometimes we don't want every element to occupy the same amount of space, or we may want our content to appear in a specific order.

In our HTML, you'll notice that some elements have been given an additional class - `large`. These items should occupy twice as much space as the others. Your first task is to have the elements with the class `large` occupy 66% of each row, while the others only occupy 33%.

You may also notice that one element has been given the class `first`, while another has been given the class `last`. Without making any changes to the HTML, your second task is to have the element with the class `first` appear first in our list, while the element with the id `last` appears last.

 # Conclusion

In this lesson we saw that Flexbox can be used to position elements within a container in a way that responds better to different screen/window sizes. We looked at some of the most common properties that can be used to control the positioning of these elements and found some documentation that should help us to achieve any layout that we might need in the future.
