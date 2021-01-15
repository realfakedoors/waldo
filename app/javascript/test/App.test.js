import React from "react";
import axios from "axios";
import mockAdapter from "axios-mock-adapter";

import {
  render,
  screen,
  fireEvent,
  getByText,
  waitFor,
  cleanup,
} from "@testing-library/react";

import App from "../components/App";

import { mockData } from "./mockData.js";

const mock = new mockAdapter(axios);

afterEach(cleanup);

test("Gameplay Flow", async () => {
  mock
    .onGet("api/v1/photos/")
    .reply(200, { data: mockData.photos, included: mockData.subjects });
  render(<App />);
  
  // Select a Photo
  mock
    .onGet("api/v1/photos/0/")
    .reply(200, { data: mockData.photos[0], included: mockData.subjects });
  mock
    .onGet("api/v1/photos/0/subjects")
    .reply(200, { data: mockData.subjects, included: mockData.targetBoxes });
  const photoName = mockData.photos[0].attributes.name;
  await waitFor(() => {
    expect(screen.getByText(photoName)).toBeDefined();
  });

  // Display that Photo's subjects
  mock
    .onGet("api/v1/photos/1/subjects")
    .reply(200, { data: mockData.subjects, included: mockData.targetBoxes });
  const subjectName = mockData.subjects[0].attributes.name;
  fireEvent.click(screen.getByText(photoName));
  await waitFor(() => {
    expect(screen.getByText(subjectName)).toBeDefined();
  });

  // Click Start
  mock
    .onGet("api/v1/photos/1/")
    .reply(200, { data: mockData.photos[0], included: mockData.subjects });
  fireEvent.click(screen.getByText("Start!"));
  await screen.findByTestId(/photo-container/);

  // Click a Subject and select their name from the dialog box
  mock.onGet("api/v1/photos/1/scores").reply(200, {
    data: mockData.scores.concat({
      attributes: {
        time: 11,
        initials: "XXX",
      },
    }),
  });
  fireEvent.click(screen.getByTestId(/photo-container/));
  fireEvent.click(screen.getByText(subjectName));
  await waitFor(() => {
    expect(screen.getByText(photoName)).toBeDefined();
    expect(screen.getByText("Enter your initials:")).toBeDefined();
  });
  
  // Enter High Score
  mock.onPost("/api/v1/photos/1/scores").reply(200, {});
  fireEvent.change(screen.getByTestId(/enter-initials/), {
    target: { value: "XXX" },
  });
  fireEvent.click(screen.getByText("Submit"));
  await waitFor(() => {
    expect(screen.getByText("XXX")).toBeDefined();
  });
  
  // Reset Game
  fireEvent.click(screen.getByText("New Game?"))
  await waitFor(() => {
    expect(screen.getByText("Tag, You're It!")).toBeDefined();
  })
});
