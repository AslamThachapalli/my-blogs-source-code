import { Hono } from 'hono'

const app = new Hono()

app.get('/', (c) => {
  return c.text('Hello Hono!');
})

app.get('/supported-locales', (c) => {
  return c.json({
    data: [
      'en',
      'hi',
      'ar'
    ]
  });
})

app.get('/:id', (c) => {
  const localeId = c.req.param('id');

  let localeData;
  if (localeId == 'en') {
    localeData = {
      "greetings": "Hello World!"
    }
  } else if (localeId == 'hi') {
    localeData = {
      "greetings": "हैलो वर्ल्ड!"
    }
  } else if (localeId == 'ar') {
    localeData = {
      "greetings": "مرحبا بالعالم!"
    }
  } else {
    c.status(404);
    return c.json({
      status: 'failed',
      message: `locale data for localeId ${localeId} is not available`
    })
  }

  return c.json({
    status: 'success',
    data: localeData
  })
})

export default app
