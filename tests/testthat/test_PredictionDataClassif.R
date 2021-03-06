test_that("PredictionDataClassif", {
  task = tsk("iris")
  learner = lrn("classif.featureless", predict_type = "prob")
  p = learner$train(task)$predict(task)
  pdata = p$data

  expect_s3_class(pdata, "PredictionDataClassif")
  expect_integer(pdata$row_ids, any.missing = FALSE)
  expect_factor(pdata$truth, levels = task$class_names, any.missing = FALSE)
  expect_factor(pdata$response, levels = task$class_names, any.missing = FALSE)
  expect_matrix(pdata$prob, nrows = task$nrow, ncols = length(task$class_names), any.missing = FALSE)

  expect_s3_class(c(pdata, pdata), "PredictionDataClassif")
  expect_prediction(as_prediction(pdata))
  expect_equal(as.data.table(p), as.data.table(as_prediction(pdata)))
})
